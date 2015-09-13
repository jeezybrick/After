__author__ = 'Jeezy'

"""
Definition of forms.
"""

from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.forms import UserCreationForm
from django.forms.extras.widgets import SelectDateWidget
from django.core import validators
from .models import Note, MyUser, LabelCustom
from .widgets import MyWidgetForColor, MyWidgetForLabels


# Форма для авторизации
class MyLoginForm(AuthenticationForm):

    username = forms.CharField(label='Логин', max_length=254,
                               widget=forms.TextInput({
                                   'class': 'form-control',
                                   'placeholder': 'Введите ваш логин'}))
    password = forms.CharField(label="Пароль",
                               widget=forms.PasswordInput({
                                   'class': 'form-control',
                                   'placeholder': 'Введите ваш пароль'}))


# Форма для регистрации
class MyRegForm(UserCreationForm):
    form_name = 'reg_form'
    error_messages = {
        'password_mismatch': "Пароли не совпадают!",
    }
    username = forms.CharField(help_text='Максимум 30 символов',
                               validators=[
                                   validators.RegexValidator(r'^[\w.@+-]+$',
                                                             'Введите правильный логин. '
                                                             'Логин может состоять из букв,цифр'
                                                             'и  @/./+/-/_ символов.',
                                                             'invalid'),
                                   ],
                               error_messages={'required': 'Это поле обязательное к запонению',
                                               'unique': 'Пользователь с таким логином уже существует'}
                               )
    password1 = forms.CharField(min_length=6, label='Пароль', widget=forms.PasswordInput,
                                help_text="Минимум 6 символов",)
    password2 = forms.CharField(min_length=6, label='Введите пароль еще раз',
                                help_text="Введите повторно пароль для проверки",
                                widget=forms.PasswordInput)
    last_name = forms.CharField(max_length=50, label='Фамилия',
                                error_messages={'required': 'Это поле обязательное к запонению'})
    first_name = forms.CharField(max_length=50, label='Имя',
                                 error_messages={'required': 'Это поле обязательное к запонению'})
    email = forms.EmailField(label='Email', required=True,
                             error_messages={'unique': 'Пользователь с таким email уже существует'})
    phone = forms.CharField(max_length=30, label='Телефон',
                            help_text='Телефон в формате ***-*******',
                            validators=[
                                validators.RegexValidator(r'^\d{3}\-\d{7}$',
                                                          'Введите телефон в правильном формате!(***-*******)',
                                                          'invalid'), ])
    date_of_birth = forms.DateField(label='Дата рождения', required=True,
                                    widget=SelectDateWidget(years=range(2015, 1940, -1)),
                                    error_messages={'invalid': 'Неверный формат даты'})

    class Meta:
        model = MyUser
        fields = ('last_name', 'first_name', 'username', 'email', 'password1', 'password2', 'date_of_birth', 'phone')

    def save(self, commit=True):
        user = super(MyRegForm, self).save(commit=False)
        user.email = self.cleaned_data['email']

        if commit:
            user.save()
        return user


# Функция для вывода родительской категории в optgroup тег
def categories_as_choices(user):
        categories = []
        for category in user.category_set.filter(parent_category_id__isnull=True):
            new_category = []
            sub_categories = []
            for sub_category in category.category_set.all():
                sub_categories.append([sub_category.id, sub_category.name])

            new_category = [category.name, sub_categories]
            categories.append(new_category)

        return categories


# Форма для редактирования/создания заметки
class ModifyNoteForm(forms.ModelForm):

    def __init__(self, user, *args, **kwargs):
        self.user = user
        super(ModifyNoteForm, self).__init__(*args, **kwargs)
        # Добавляем атрибуты к fields
        self.fields['categories'].choices = categories_as_choices(self.user)
        self.fields['categories'].label = 'Категории'
        self.fields['labels'].label = 'Ярлыки'
        self.fields['color'].label = 'Цвет заметки'
        self.fields['categories'].help_text = '<a href="/personal/categories/">Щелкните чтобы добавить категории</a>.<br />' \
                                              'Для выбора нескольких категорий зажмите клавишу Ctrl.'

    message = forms.CharField(label='Текст', widget=forms.Textarea(attrs={'cols': 20, 'rows': 5}))
    categories = forms.MultipleChoiceField(required=False)
    file = forms.FileField(label='Прикрепить файл', required=False)

    class Meta:
        model = Note
        fields = ('title', 'message', 'color', 'categories', 'labels', 'file', )
        widgets = {
            # 'categories': forms.CheckboxSelectMultiple(attrs={'class': 'lal'}),
            'labels': MyWidgetForLabels(attrs={'class': 'label_picker'}),
            # 'color': MyWidgetForColor(),
        }


# Форма для редактирования личных данных пользовтеля
class EditProfileForm(forms.ModelForm):

    date_of_birth = forms.DateField(label='Дата рождения', required=True,
                                    widget=SelectDateWidget(years=range(2015, 1940, -1)))
    phone = forms.CharField(max_length=30, label='Телефон',
                            help_text='Телефон в формате ***-*******',
                            validators=[
                                validators.RegexValidator(r'^\d{3}\-\d{7}$',
                                                          'Введите телефон в правильном формате!(***-*******)',
                                                          'invalid'), ])

    class Meta:
        model = MyUser
        fields = ('last_name', 'first_name', 'username', 'email', 'date_of_birth', 'phone', 'is_private', )
        exclude = ('password',)


# Форма для загрузки аватарки
class EditAvatarForm(forms.ModelForm):

    avatar = forms.ImageField(label='Загрузить аватарку')

    class Meta:
        model = MyUser
        fields = ('avatar', )


# Форма для добавления собственных ярлыков
class AddLabelForm(forms.ModelForm):
    file = forms.ImageField(label='Добавить значки')

    class Meta:
        model = LabelCustom
        fields = ('file', )