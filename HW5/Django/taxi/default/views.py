from django.shortcuts import render
from django.shortcuts import redirect
from django.http import HttpResponse
from .models import Users
from .models import Role
from .models import City
from .models import Travel
from .models import Bookmark
from .models import TravelVote
from .forms import RoleForm
from .forms import BookmarkForm
from .forms import RegisterForm
from .forms import EditForm
from .forms import TravelForm
from .forms import PriceForm
from .forms import CityForm
from django.contrib.auth import authenticate, login
from django.contrib.auth import logout
from django.core.exceptions import SuspiciousOperation
from django.http import HttpResponseForbidden
from .decorators import driver_required
from .decorators import passenger_required
from .decorators import admin_required
from django.contrib.auth.decorators import login_required
import datetime
from django.db.models import Avg


def index(request):
    users = Users.objects.all()[:10]
    context = {
        'users': users
    }
    return render(request, 'index.html', context)


@login_required
@admin_required
def RoleAdd(request, id=0):
    if (request.method == 'POST'):
        if(id):
            # Update
            instance = Role.objects.get(id=id)
            form = RoleForm(data=request.POST, instance=instance)
            if form.is_valid():
                form.save()
        else:
            # Add
            name = request.POST['name']
            newrole = Role(name=name)
            newrole.save()
        return redirect('/role/list')
    else:
        if(id):
            # Update
            instance = Role.objects.get(id=id)
            form = RoleForm(instance=instance)
        else:
            # Add
            form = RoleForm()
        return render(request, 'RoleAdd.html', {'form': form})


@login_required
@admin_required
def RoleList(request):
    roles = Role.objects.all()
    context = {
        'roles': roles
    }
    return render(request, 'RoleList.html', context)


@login_required
@admin_required
def RoleDelete(request, id=0):
    if(id):
        # delete
        instance = Role.objects.get(id=id)
        instance.delete()
    else:
        # show delete form
        pass
    return redirect('/role/list')


def loginPage(request):
    if(request.method == "POST"):
        username = request.POST['mobile']
        password = request.POST['password']
        user = Users.objects.get(mobile=username)
        user.backend = 'django.contrib.auth.backends.ModelBackend'
        if user.is_active is False:
            return HttpResponseForbidden("Invalid request; Not active user")
        if user is not None:
            login(request, user)
            if(user.role_id == 2):
                return redirect("/passenger-dashboard")
            elif(user.role_id == 3):
                return redirect("/driver-dashboard")
            return redirect("/")
        else:
            return redirect("/login/")
    else:
        return render(request, "login.html")


def logoutPage(request):
    logout(request)
    return redirect('/')


def register(request):
    if(request.method == 'POST'):
        user_form = RegisterForm(data=request.POST)
        user_form.instance.profit = 0
        user_form.instance.is_active = True
        # user_form.instance.password = user_form.set_password(user_form.instance.password)
        if int(request.POST['role']) == 1:
            return HttpResponseForbidden("Invalid request; Role not valid")
        if user_form.is_valid():
            user = user_form.save()
            user.save()
            u = Users.objects.get(username=request.POST['mobile'])
            u.set_password(request.POST['password'])
            u.save()
            return redirect('/login')
    else:
        form = RegisterForm()
        return render(request, 'Register.html', {'form': form})


@login_required
@passenger_required
def passengerDashboard(request):
    user = request.user
    travel_count = Travel.objects.filter(passenger_mobile=user.mobile).count()
    context = {
        'user': user,
        'travel_count': travel_count
    }
    return render(request, 'passengerDashboard.html', context)


@login_required
@driver_required
def driverDashboard(request):
    user = request.user
    travel_count = Travel.objects.filter(driver_mobile=user.mobile).count()
    avg = TravelVote.objects.filter(to=user.mobile).aggregate(Avg('star'))['star__avg']
    context = {
        'user': user,
        'travel_count': travel_count,
        'avg': avg
    }
    return render(request, 'driverDashboard.html', context)


@login_required
@admin_required
def adminDashboard(request):
    user = request.user
    context = {
        'user': user
    }
    return render(request, 'adminDashboard.html', context)


@login_required
@passenger_required
def BookmarkAdd(request, id=0):
    user = request.user
    if (request.method == 'POST'):
        if(id):
            # Update
            instance = Bookmark.objects.get(id=id)
            form = BookmarkForm(data=request.POST, instance=instance)
            if form.is_valid():
                form.save()
        else:
            # Add
            lat = request.POST['lat']
            lon = request.POST['lon']
            title = request.POST['title']
            passenger_mobile = user
            newBookmark = Bookmark(title=title, lat=lat, lon=lon, passenger_mobile=passenger_mobile)
            newBookmark.save()
        return redirect('/passenger-dashboard/')
    else:
        if(id):
            # Update
            instance = Bookmark.objects.get(id=id)
            form = BookmarkForm(instance=instance)
        else:
            # Add
            form = BookmarkForm()
        return render(request, 'BookmarkAdd.html', {'form': form, 'Bookmarks': Bookmark.objects.filter(passenger_mobile=user.mobile)})


@login_required
@passenger_required
def charge(request):
    user = request.user
    user.profit = user.profit + 5000
    user.save()
    return redirect('/passenger-dashboard/')


@login_required
def edit(request):
    if (request.method == 'POST'):
        instance = Users.objects.get(mobile=request.user.mobile)
        form = EditForm(data=request.POST, instance=instance)
        if form.is_valid():
            form.save()
        if(request.user.role_id == 2):
            return redirect('/passenger-dashboard/')
        elif(request.user.role_id == 3):
            return redirect('/driver-dashboard/')
    else:
        instance = Users.objects.get(mobile=request.user.mobile)
        form = EditForm(instance=instance)
    return render(request, 'editProfile.html', {'form': form, 'role_id': request.user.role_id})


@passenger_required
@login_required
def addTravel(request):
    if (request.method == 'POST'):
        travel_form = TravelForm(data=request.POST)
        if int(request.user.profit) < int(request.POST['final_price']):
            travel_form.instance.profit = 0
        travel_form.instance.passenger_mobile = request.user
        travel_form.instance.starttime = datetime.datetime.now()
        if travel_form.is_valid():
            travel = travel_form.save()
            travel.save()
            return redirect('/passenger-dashboard')
    else:
        form = TravelForm()
    return render(request, 'addTravel.html', {'form': form})


@passenger_required
@login_required
def viewTravel(request, id):
    pass


@login_required
def listTravel(request):
    if(request.user.role_id == 2):
        travel = Travel.objects.filter(passenger_mobile=request.user)
    elif(request.user.role_id == 3):
        travel = Travel.objects.filter(driver_mobile=request.user)
    else:
        travel = Travel.objects.all
    context = {
        'travels': travel,
        'role_id': request.user.role_id
    }
    return render(request, 'Travellist.html', context)


@driver_required
@login_required
def findTravel(request):
    travel = Travel.objects.filter(driver_mobile__isnull=True)
    context = {
        'travels': travel,
        'role_id': request.user.role_id
    }
    return render(request, 'Travellist.html', context)


@driver_required
@login_required
def accTravel(request, id):
    travel = Travel.objects.filter(travel_id=id)
    for objects in travel:
        objects.driver_mobile = request.user
        objects.save()
        request.user.profit = request.user.profit + objects.final_price
        request.user.save()
    return redirect("/driver-dashboard/")


@login_required
@admin_required
def listUser(request):
    user = Users.objects.all()
    context = {
        'users': user
    }
    return render(request, 'userlist.html', context)


@login_required
@admin_required
def listCity(request):
    city = City.objects.all()
    context = {
        'city': city
    }
    return render(request, 'citylist.html', context)


@login_required
@admin_required
def deactiveUser(request, id):
    user = Users.objects.filter(mobile=id)
    for u in user:
        u.is_active = False
        u.save()
    return redirect("/user/list")


@admin_required
@login_required
def addCity(request):
    if (request.method == 'POST'):
        city_form = CityForm(data=request.POST)
        if city_form.is_valid():
            c = city_form.save()
            c.save()
            return redirect('/admin-dashboard')
    else:
        form = CityForm()
    return render(request, 'addCity.html', {'form': form})


@admin_required
@login_required
def priceCity(request):
    if (request.method == 'POST'):
        price_form = PriceForm(data=request.POST)
        if price_form.is_valid():
            p = price_form.save()
            p.save()
            return redirect('/admin-dashboard')
    else:
        form = PriceForm()
    return render(request, 'addPrice.html', {'form': form})
