__author__ = 'Jeezy'

from django.conf.urls import include, url
from django.views.generic import ListView, DetailView, TemplateView
from django.contrib.auth.decorators import login_required
from notes.forms import MyLoginForm
from notes.views import RegisterView, PersonalEditView, NoteEditView, \
    NoteCreateView, NoteDeleteView, NotesList, LabelDeleteView, EditAvatarView, CreateLabelList, \
    CategoryDeleteView,CategoriesView
from .models import MyUser, Note

urlpatterns = [
    url(r"^$", TemplateView.as_view(
        template_name='notes/home.html'
    ), name='home'),
    url(r'^auth/login/$',
        'django.contrib.auth.views.login',
        {
            'template_name': 'notes/auth/login.html',
            'authentication_form': MyLoginForm,
            'extra_context':
            {
                'title': 'Вход пользователя',
            }
        },
        name='login'),
    url(r'^auth/logout/$',
        'django.contrib.auth.views.logout',
        {
            'next_page': '/',
        },
        name='logout'),
    url(r"^auth/register/$", RegisterView.as_view(), name='register'),
    url(r"^auth/register/success/$", TemplateView.as_view(
        template_name='notes/auth/register_success.html'
    ), name='register_success'),
    url(r"^personal/$", login_required(TemplateView.as_view(
        template_name='notes/personal/index.html'
    ), login_url='/auth/login/'), name='personal_show'),
    url(r"^personal/categories/$", CategoriesView.as_view(), name='personal_categories'),
    url(r"^personal/categories/(?P<pk>[0-9]+)/delete/$", CategoryDeleteView.as_view(),
        name='personal_categories_delete'),
    url(r"^personal/edit/$", PersonalEditView.as_view(), name='personal_edit'),
    url(r"^personal/edit/avatar/$", EditAvatarView.as_view(), name='personal_edit_avatar'),
    url(r"^users/$", ListView.as_view(
        model=MyUser,
        paginate_by=1,
        queryset=MyUser.objects.all().order_by('id'),
        context_object_name='users_list',
        template_name='notes/users/index.html'
    ), name='users'),
    url(r"^users/(?P<slug>\w+)/$", DetailView.as_view(
        context_object_name='user',
        model=MyUser,
        template_name='notes/users/show.html',
        slug_field='username'
    ), name='user_show'),
    url(r"^users/(?P<username>\w+)/notes/$", NotesList.as_view(), name='user_notes'),
    url(r"^users/(?P<username>\w+)/notes/add/$", NoteCreateView.as_view(), name='user_notes_add'),
    url(r"^users/(?P<username>\w+)/notes/(?P<pk>[0-9]+)/$", DetailView.as_view(
        context_object_name='note',
        model=Note,
        template_name='notes/notes/show.html'
    ), name='user_notes_show'),
    url(r"^users/(?P<slug>\w+)/notes/(?P<pk>[0-9]+)/edit/$",
        NoteEditView.as_view(),
        name='user_notes_edit'),
    url(r"^users/(?P<slug>\w+)/notes/(?P<pk>[0-9]+)/delete/$",
        NoteDeleteView.as_view(),
        name='user_notes_delete'),
    url(r"^users/(?P<username>\w+)/notes/(?P<note_id>[0-9]+)/labels/add/$",
        CreateLabelList.as_view(),
        name='user_notes_labels_add'),
    url(r"^users/(?P<username>\w+)/notes/(?P<note_id>[0-9]+)/labels/(?P<pk>[0-9]+)/delete/$",
        LabelDeleteView.as_view(),
        name='user_notes_labels_delete'),
]