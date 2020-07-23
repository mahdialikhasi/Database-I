from django import forms
from .models import Role
from .models import Bookmark
from .models import Users
from .models import City
from .models import Travel
from .models import PricePerCity
from django.forms import ModelChoiceField


class MyModelChoiceField(ModelChoiceField):
    def label_from_instance(self, obj):
        return "Role #%s" % obj.name


class MyModelChoiceField2(ModelChoiceField):
    def label_from_instance(self, obj):
        return "city #%s" % obj.name


class RoleForm(forms.ModelForm):
    class Meta:
        model = Role
        fields = ['name', 'id']


class CityForm(forms.ModelForm):
    class Meta:
        model = City
        fields = ['name', 'id']


class RegisterForm(forms.ModelForm):
    password = forms.CharField(widget=forms.PasswordInput())
    role = MyModelChoiceField(queryset=Role.objects.exclude(name='Admin'))
    city = MyModelChoiceField2(queryset=City.objects.all())

    class Meta:
        model = Users
        fields = ['mobile', 'name', 'lastname', 'role', 'city', 'password']

    def __init__(self, *args, **kwargs):
        super(RegisterForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'mdl-textfield__input'


class TravelForm(forms.ModelForm):
    city = MyModelChoiceField2(queryset=City.objects.all())

    class Meta:
        model = Travel
        fields = ['travel_id', 'start_point', 'start_point_lon', 'destination_lat', 'destination_lon', 'type_of_payment', 'price', 'final_price', 'city']

    def __init__(self, *args, **kwargs):
        super(TravelForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'mdl-textfield__input'


class PriceForm(forms.ModelForm):
    id = MyModelChoiceField2(queryset=City.objects.all())

    class Meta:
        model = PricePerCity
        fields = ['id', 'price_per_kilometer']

    def __init__(self, *args, **kwargs):
        super(PriceForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'mdl-textfield__input'


class EditForm(forms.ModelForm):
    city = MyModelChoiceField2(queryset=City.objects.all())

    class Meta:
        model = Users
        fields = ['name', 'lastname', 'city']

    def __init__(self, *args, **kwargs):
        super(EditForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'mdl-textfield__input'


class BookmarkForm(forms.ModelForm):
    class Meta:
        model = Bookmark
        fields = ['title', 'lat', 'lon']

    def __init__(self, *args, **kwargs):
        super(BookmarkForm, self).__init__(*args, **kwargs)
        for visible in self.visible_fields():
            visible.field.widget.attrs['class'] = 'mdl-textfield__input'
