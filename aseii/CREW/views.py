from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse
from django.shortcuts import redirect
from .models import *
import urllib
from datetime import datetime
from django.views.decorators.csrf import *
from django.urls import reverse
# Create your views here.

def home(request):
    return render(request,'CREW/login.html',{})

def login(request):
	if request.method == 'POST':
		email = request.POST.get('emailId')
		password = request.POST.get('password')
		if user.objects.filter(user_email = email,user_password = password).exists():
			usr = user.objects.get(user_email = email,user_password = password)
			typ = usr.user_type
			if(typ =='student'):
				return redirect('student',usr.id)
			elif(typ == 'Club Admin'):
				return redirect('Club_Admin',usr.id)
			elif(typ == 'Super Admin'):
				return redirect('Super_Admin',usr.id)
			else:
				return render(request,'CREW/login.html',{})
		else:
			return render(request,'CREW/login.html',{})

def profile(request):
	return render(request,'CREW/student_index.html',{})

def student(request,s_id):
	usr = user.objects.get(id = s_id)
	clubs_joined = set(club_registered_member.objects.filter(user_id = usr).values_list('club_id',flat=True))
	clubs = set(club.objects.all().values_list('id',flat=True))
	clubs_remaining = list(clubs - clubs_joined)
	clubs_remain = club.objects.filter(id__in = clubs_remaining).order_by('club_name')
	myposts_count = post.objects.filter(posted_by_id = usr).count()
	notification_ids = list(notification_user.objects.filter(id = s_id, view_type = False).values_list('notification_id',flat=True))
	notifications_to_show = notification.objects.filter(id__in = notification_ids).order_by('notification_datetime')
	dic = {
			"user":usr ,
			"clubs_remain":clubs_remain,
			"clubs":club.objects.all(),
			"clubs_no":len(clubs_joined),
			"clubs_joined": list(clubs_joined),
			"myposts_count": myposts_count,
			"notifications" : notifications_to_show,
			"notif_no": notifications_to_show.count(),
			#"events_no":len(events_registered),
			}
	return render(request,'CREW/student_index.html',dic)

def notifications_seen(request):
	if request.method == "POST":
		s_id = request.POST.get('s_id')

		notifs_seen = notification_user.objects.filter(user_id = s_id).update(view_type = True)
		print(notifs_seen)
		return redirect('student',s_id)	

def Club_Admin(request,ca_id):
	return render(request,'CREW/CA_index.html',{})

def Super_Admin(request,sa_id):
	usr = user.objects.get(id = sa_id)
	total_clubs = club.objects.all().count()
	myposts_count = post.objects.filter(posted_by_id = usr).count()
	dic = {
			"user":usr ,
			"clubs_no":total_clubs,
			"myposts_count": myposts_count,
			#"events_no":len(events_registered),
			}
	return render(request,'CREW/SA_index.html',dic)

def join(request):
	if request.method == "POST":
		clubName = request.POST.get('Club')
		s_id = request.POST.get('s_id')
		usr = user.objects.get(id = s_id)
		Club = club.objects.get(club_name = clubName)
		club_registered_member.objects.create(user_id = usr, club_id = Club, date_of_joining = datetime.now())
		return redirect('student',s_id)

def create_post(request):
	if request.method == "POST":
		title = request.POST.get('post_title')
		club_name = request.POST.get('Club')
		content = request.POST.get('content')
		File = request.FILES.getlist('File')
		s_id = request.POST.get('s_id')
		usr = user.objects.get(id = s_id)
		Club = club.objects.get(club_name=club_name)
		Post = post.objects.create(club_id = Club, posted_by_id = usr, content = content, post_datetime = datetime.now())
		for file in File:
			if(file.name.lower().endswith('.png') or file.name.lower().endswith('.jpg') or file.name.lower().endswith('.jpeg') or file.name.lower().endswith('.png')):
				post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
			
		return redirect('student',s_id)

def organize_event(request):
	if request.method == 'POST':
		if request.POST.get('event_title') and request.POST.get('event_description') and request.POST.get('start_datetime') and request.POST.get('type') and request.POST.get('end_datetime') and request.POST.get('room') and request.POST.get('host') and request.POST.get('limit') and request.POST.get('event_media'):
			Event=event()
			Event.event_name = request.POST.get('event_title')
			#Event.description = request.POST.get('event_description')
			Event.event_start_datetime = request.POST.get('start_datetime')
			Event.event_end_datetime = request.POST.get('end_datetime')
			Event.event_venue = request.POST.get('room')
			Event.event_type = request.POST.get('type')
			Event.event_host = request.POST.get('host')
			Event.event_limit = request.POST.get('limit')
			Event.organizer_id = request.POST.get('organizer')
			Event.event_duration = request.POST.get('duration')
			Event.event_file = request.POST.get('event_media')
			Event.save()

			return render(request, 'CREW/CA_index.html')
	else:
		return render(request, 'CREW/CA_index.html')

@csrf_protect
def clubs_joined(request):
	if request.method == "POST":
		s_id = request.POST.get('s_id')
		usr = user.objects.get(id = s_id)
		clubs_joined = club_registered_member.objects.filter(user_id = usr)
		clubs = club.objects.all()
		dic = {
				"id":usr.id ,
				"clubs_joined":clubs_joined,
				"clubs":club.objects.all(),
				#"events_no":len(events_registered),
				}
		return render(request,'CREW/clubs_joined.html',dic)

def add_club(request):
	if request.method == "POST":
		sa_id = request.POST.get('sa_id')
		club_name = request.POST.get('club_name')
		description = request.POST.get('description')
		tc_doc = request.FILES['tc_doc']
		club_icon = request.FILES['club_icon']
		created_club = club.objects.create(club_name = club_name, club_description = description, club_tc = tc_doc, club_logo = club_icon)
		if("club" in club_name):
			content = club_name + "club is added."
		else:
			content = club_name + " is added."
		
		new_notification = notification.objects.create(club_id = created_club , notification_content=content)
		
		usersToBeNotified = user.objects.all().exclude(id = sa_id)
		
		for usr in usersToBeNotified:
			 notification_user.objects.create(user_id = usr , notification_id = new_notification)
		return redirect('Super_Admin',sa_id)

def conduct_poll(request):
	if request.method=="POST":
		poll_title = request.POST.get('poll_title')
		poll_description = request.POST.get('poll_description')
		poll_start_datetime = request.POST.get('poll_start')
		poll_end_datetime = request.POST.get('poll_end')
		poll_type = request.POST.get('pollOption_type')
		usr_id = request.POST.get('user_id')
		usr = user.objects.get(id = usr_id)  
		no_of_options = request.POST.get('no_of_options')
		print("poll_title :",poll_title)
		print("poll_description :",poll_description)
		print("poll_starttime :",poll_start_datetime)
		print("poll_endtime :",poll_end_datetime)
		print("poll_type :",poll_type)
		print("no_of_options :",no_of_options)
		poll_created = poll.objects.create(poll_title = poll_title, poll_description = poll_description,poll_type = poll_type, user_id = usr,start_datetime = poll_start_datetime,end_datetime = poll_end_datetime)
		for i in range(1,int(no_of_options)+1):
			title_no = "opt"+str(i)+"_title"
			image_no = 'opt'+str(i)+'_img'
			image = request.FILES[image_no]
			option = request.POST.get(title_no)
			poll_options.objects.create(poll_id = poll_created, option = option, image = image)
		return redirect('Super_Admin',usr_id)


		











