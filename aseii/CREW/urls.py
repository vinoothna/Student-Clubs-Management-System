from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('login',views.login,name='login'),
    path('join',views.join,name='join'),
    path('add_club',views.add_club,name='add_club'),
    path('create_post',views.create_post,name='create_post'),
    path('conduct_poll',views.conduct_poll,name='conduct_poll'),
    path('notifications_seen',views.notifications_seen,name='notifications_seen'),
    path('student/<int:s_id>',views.student,name='student'),
    path('Club_Admin',views.Club_Admin,name='Club_Admin'),
    path('Super_Admin/<int:sa_id>',views.Super_Admin,name='Super_Admin'),
    path('organize_event',views.organize_event,name='organize_event'),
    path('clubs_joined',views.clubs_joined,name='clubs_joined')
]

