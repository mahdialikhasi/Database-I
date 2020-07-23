from django.urls import re_path
from . import views

urlpatterns = [
    re_path('login/$', views.loginPage, name='Login'),
    re_path('passenger-dashboard/$', views.passengerDashboard, name='Passenger Dashboard'),
    re_path('driver-dashboard/$', views.driverDashboard, name='Driver Dashboard'),
    re_path('admin-dashboard/$', views.adminDashboard, name='admin Dashboard'),
    re_path('charge/$', views.charge, name='Charge'),
    re_path('bookmark/add/$', views.BookmarkAdd, name='Bookmark Add'),
    re_path('logout/$', views.logoutPage, name='Logout'),
    re_path('register/$', views.register, name='Register'),
    re_path('edit/$', views.edit, name='Edit'),
    re_path('role/list/$', views.RoleList, name='Role List'),
    re_path('role/add/$', views.RoleAdd, name='Role Add'),
    re_path('role/update/(?P<id>\d+)/', views.RoleAdd, name='Role Edit'),
    re_path('role/delete/(?P<id>\d+)/', views.RoleDelete, name='Delete'),
    re_path('travel/view/(?P<id>\d+)/', views.viewTravel, name='View Travel'),
    re_path('travel/add/$', views.addTravel, name='Travel Add'),
    re_path('travel/list/$', views.listTravel, name='Travel list'),
    re_path('travel/find/$', views.findTravel, name='Travel find'),
    re_path('travel/accept/(?P<id>\d+)/', views.accTravel, name='Travel accept'),
    re_path('user/list/$', views.listUser, name='User list'),
    re_path('user/deactive/(?P<id>\d+)/', views.deactiveUser, name='User Deactive'),
    re_path('city/list/$', views.listCity, name='City list'),
    re_path('city/add/$', views.addCity, name='City add'),
    re_path('city/price/$', views.priceCity, name='City price'),
    re_path('^$', views.index, name='index'),
]
