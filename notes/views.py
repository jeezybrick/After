from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.views.generic import View, ListView
from django.contrib.auth.decorators import login_required
from django.views.generic.edit import FormView, CreateView, UpdateView, DeleteView

from .models import MyUser, Note, Category, LabelCustom
from .forms import MyRegForm, EditAvatarForm


class LoginRequiredMixin(object):
    @classmethod
    def as_view(cls, **initkwargs):
        view = super(LoginRequiredMixin, cls).as_view(**initkwargs)
        return login_required(view, login_url='/auth/login/')


class RegisterView(View):
    form_class = MyRegForm
    template_name = 'notes/auth/register.html'

    def get(self, request):
        form = self.form_class()
        return render(request, self.template_name, {'form': form})

    def post(self, request):
        form = self.form_class(request.POST)
        if form.is_valid():
            form.save()
            return HttpResponseRedirect('/auth/register/success')
        return render(request, self.template_name, {'form': form})


class NotesList(LoginRequiredMixin, ListView):

    template_name = 'notes/notes/index.html'
    context_object_name = 'notes'
    paginate_by = 2

    def get_queryset(self):
        self.user = get_object_or_404(MyUser, username=self.kwargs['username'])
        return Note.objects.filter(user=self.user)

    def get_context_data(self, **kwargs):
        # Call the base implementation first to get a context
        context = super(NotesList, self).get_context_data(**kwargs)
        # Add in the publisher
        context['user_owner'] = self.user
        return context


class PersonalEditView(LoginRequiredMixin, UpdateView):
    model = MyUser
    fields = ['last_name', 'first_name', 'username', 'email', 'date_of_birth', 'phone', 'is_private']
    template_name = 'notes/personal/edit.html'
    success_url = '/personal/'

    def get_object(self):
        return get_object_or_404(MyUser, pk=self.request.user.id)

    def form_valid(self, form):
        messages.success(self.request, 'Личные данные успешно отредактированы!')
        return super(PersonalEditView, self).form_valid(form)


class NoteEditView(LoginRequiredMixin, UpdateView):
    model = Note
    fields = ('title', 'message', 'color', 'categories', 'labels', 'file', )
    template_name = 'notes/notes/modify.html'
    success_url = '/personal/'


class NoteCreateView(LoginRequiredMixin, CreateView):
    model = Note
    fields = ('title', 'message', 'color', 'categories', 'labels', 'file', )
    template_name = 'notes/notes/modify.html'
    success_url = '/'

    def form_valid(self, form):
        form.instance.user_id = self.request.user.id
        return super(NoteCreateView, self).form_valid(form)


class NoteDeleteView(LoginRequiredMixin, DeleteView):
    model = Note
    success_url = '/'


class CreateLabelList(LoginRequiredMixin, CreateView):

    model = LabelCustom
    fields = ('file', )
    template_name = 'notes/labels/add.html'
    success_url = '/personal/'

    def form_valid(self, form):
        form.instance.note = self.request.user.note_set.get(id=self.kwargs['note_id'])
        messages.success(self.request, 'Ярлык добавлен!')
        return super(CreateLabelList, self).form_valid(form)


class LabelDeleteView(LoginRequiredMixin, DeleteView):
    model = LabelCustom
    success_url = '/personal/'

    def form_valid(self):
        messages.success(self.request, 'Ярлык удален!')


class EditAvatarView(LoginRequiredMixin, View):
    form_class = EditAvatarForm
    template_name = 'notes/users/avatar.html'

    def get(self, request):
        form = self.form_class(instance=request.user)
        return render(request, self.template_name, {'form': form})

    def post(self, request):
        form = self.form_class(request.POST, request.FILES, instance=request.user)
        request.FILES['avatar'].name = str(request.user.username) + request.FILES['avatar'].name[-4:]
        if form.is_valid():
            form.save()
            messages.success(request, 'Аватар успешно загружен!')
            return HttpResponseRedirect('/personal/')
        return render(request, self.template_name, {'form': form})


class CategoriesView(LoginRequiredMixin, View):
    template_name = 'notes/personal/categories.html'

    def get(self, request):
        parent_note = request.user.category_set.filter(parent_category_id__isnull=True)
        return render(request, self.template_name, {'parent_note': parent_note})

    def post(self, request, *args, **kwargs):
        # Ошибка если пользователь не указал родительскую категорию
        try:
            kwargs["parent"]
        except:
            raise Exception('Вы не ввели значение для главной категории!')
        # Создаем новый обьект и сохраняем его
        parent = Category(name=request.POST["parent"], user_id=request.user.id)
        parent.save()
        callback = 'Категория добавлена!'
        # Перебираем список дочерних категорий,создаем и сохраняем их обьекты
        for value in request.POST.getlist("child"):
            child = Category(name=value, parent_category_id=parent.id, user_id=request.user.id)
            child.save()
            callback = 'Категории добалены!'
        messages.success(request, callback)
        return HttpResponseRedirect('/personal/')


class CategoryDeleteView(LoginRequiredMixin, DeleteView):
    model = Category
    success_url = '/personal/categories/'

    def form_valid(self):
        messages.success(self.request, 'Категория удалена!')