from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse
from django.shortcuts import redirect
from .models import *
import urllib
from datetime import datetime
from django.views.decorators.csrf import *
from django.urls import reverse
from django.db.models import F
from django.conf import settings
# Create your views here.
import requests, json


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

def dashboard(request,token):
	student_details = auth_from_api(token)
	print(student_details) 
	email = student_details['student'][0]['Student_Email']
	name = student_details['student'][0]['Student_First_Name'] 
	if user.objects.filter(user_email=email).exists() == False:
		user_data = user(user_name = name,user_email=email,user_type = 'student')
		user_data.save()
		typ = user_data.user_type
	else:
		user_data = user.objects.get(user_email = email) 
		typ = user_data.user_type
	if(typ =='student'):
		return redirect('student',user_data.id)
	elif(typ == 'Club Admin'):
		return redirect('Club_Admin',user_data.id)
	elif(typ == 'Super Admin'):
		return redirect('Super_Admin',user_data.id)
	else:
		return render(request,'CREW/login.html',{})
	

def auth_from_api(token):	
	
	url = " https://serene-wildwood-35121.herokuapp.com/oauth/getDetails"
	Payload = { 'token': token, 'secret': "1c7bfdbc537818fc991f5b014c37632c8a1724e224f3725c1138ccd649f4892e9bf4a1824ccdeffd66cd8df9e8741eb0887d8ae1679c8ccc3f9e6692590dba95" }
	k = requests.post(url ,Payload)
	details = json.loads(k.content)
	print(details)
	return details

def student(request,s_id):
	usr = user.objects.get(id = s_id)
	clubs_joined = set(club_registered_member.objects.filter(user_id = usr).values_list('club_id',flat=True))
	clubs = set(club.objects.all().values_list('id',flat=True))
	clubs_remaining = list(clubs - clubs_joined)
	clubs_remain = club.objects.filter(id__in = clubs_remaining).order_by('club_name')
	myposts_count = post.objects.filter(posted_by_id = usr).count()
	new_notification_ids = list(notification_user.objects.filter(user_id = s_id, view_type = False).values_list('notification_id',flat=True))
	new_notifications_to_show = notification.objects.filter(id__in = new_notification_ids).order_by('notification_datetime')
	old_notification_ids = list(notification_user.objects.filter(user_id = s_id, view_type = True).values_list('notification_id',flat=True))
	old_notifications_to_show = notification.objects.filter(id__in = old_notification_ids).order_by('notification_datetime')
	
	posts = post.objects.filter(club_id__in = list(clubs_joined)).order_by('-post_datetime')
	post_ids = list(posts.values_list('id',flat=True))
	posts_media = post_media.objects.filter(post_id__in = post_ids)
	post_comments = comment.objects.filter(post_id__in = post_ids).order_by('-comment_datetime')
	
	events_registered = list(event_registered_user.objects.filter(user_id = usr).values_list('event_id',flat=True))
	events = event.objects.filter(club_id__in = list(clubs_joined)).exclude(event_fill_status=F('event_limit'))
	events = events.exclude(id__in = events_registered )
	event_ids = list(events.values_list('id',flat=True))
	events_media = event_media.objects.filter(event_id__in = event_ids)

	
	polls = poll.objects.all()
	no_of_polls = polls.count()
	Poll_options = poll_options.objects.all()
	print(Poll_options)

	dic = {
			"user":usr ,
			"clubs_remain":clubs_remain,
			"clubs":club.objects.all(),
			"clubs_no":len(clubs_joined),
			"clubs_joined": list(clubs_joined),
			"myposts_count": myposts_count,
			"new_notifications" : new_notifications_to_show,
			"new_notif_no": new_notifications_to_show.count(),
			"old_notifications" : old_notifications_to_show,
			"events": events,
			"events_media": events_media,
			"events_registered": events_registered,
			"no_events_registered": len(events_registered),
			"posts" : posts,
			"posts_media" : posts_media,
			"post_comments" : post_comments,
			"media_url" : settings.MEDIA_URL,
			"polls":polls,
			"no_of_polls":no_of_polls,
			"poll_options":Poll_options,
			}
	return render(request,'CREW/student_index.html',dic)

def notifications_seen(request):
	if request.method == "POST":
		if request.POST.get('s_id'):
			s_id = request.POST.get('s_id')
			notifs_seen = notification_user.objects.filter(user_id = s_id).update(view_type = True)
			print(notifs_seen)
			return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			ca_id = request.POST.get('ca_id')
			notifs_seen = notification_user.objects.filter(user_id = ca_id).update(view_type = True)
			print(notifs_seen)
			return redirect('Club_Admin',ca_id)
		elif request.POST.get('sa_id'):
			sa_id = request.POST.get('sa_id')
			notifs_seen = notification_user.objects.filter(user_id = sa_id).update(view_type = True)
			return redirect('Super_Admin',sa_id)

def Club_Admin(request,ca_id):
	usr = user.objects.get(id = ca_id)
	for_club = (club_admin.objects.filter(user_id = usr).values_list('club_id',flat=True))[0]
	Club = club.objects.get(id = for_club)
	no_of_students = club_registered_member.objects.filter(club_id = Club)


	clubs_joined = set(club_registered_member.objects.filter(user_id = usr).values_list('club_id',flat=True))
	clubs = set(club.objects.all().values_list('id',flat=True))
	clubs_remaining = list(clubs - clubs_joined)
	clubs_remain = club.objects.filter(id__in = clubs_remaining).order_by('club_name')
	clubs_remain = clubs_remain.exclude(id = for_club)
	

	new_notification_ids = list(notification_user.objects.filter(user_id = ca_id, view_type = False).values_list('notification_id',flat=True))
	new_notifications_to_show = notification.objects.filter(id__in = new_notification_ids).order_by('notification_datetime')
	old_notification_ids = list(notification_user.objects.filter(user_id = ca_id, view_type = True).values_list('notification_id',flat=True))
	old_notifications_to_show = notification.objects.filter(id__in = old_notification_ids).order_by('notification_datetime')
	
	# exclude all the events organized by he himself
	# exclude all the events already registered for

	events_registered = list(event_registered_user.objects.filter(user_id = usr).values_list('event_id',flat=True))
	events = event.objects.filter(club_id__in = list(clubs_joined)).exclude(event_fill_status=F('event_limit'))
	events = events.exclude(id__in = events_registered )
	events = events.exclude(club_id = Club)
	event_ids = list(events.values_list('id',flat=True))
	events_media = event_media.objects.filter(event_id__in = event_ids)

		
	
	myposts_count = post.objects.filter(posted_by_id = usr).count()
	posts = post.objects.filter(club_id__in = list(clubs_joined)).order_by('-post_datetime')
	post_ids = list(posts.values_list('id',flat=True))
	posts_media = post_media.objects.filter(post_id__in = post_ids)
	post_comments = comment.objects.filter(post_id__in = post_ids).order_by('-comment_datetime')
	my_club_posts = post.objects.filter(club_id = Club)	
	

	events_organized = event.objects.filter(club_id = Club)

	dic = {
			"user":usr ,
			"clubs_remain":clubs_remain,
			"clubs":club.objects.all(),
			"clubs_no":len(clubs_joined),
			"clubs_joined": list(clubs_joined),
			"myposts_count": myposts_count,
			"new_notifications" : new_notifications_to_show,
			"new_notif_no": new_notifications_to_show.count(),
			"old_notifications" : old_notifications_to_show,
			"no_of_students": no_of_students.count(),
			"events": events,
			"events_media": events_media,
			"events_organized" : events_organized.count(),
			"posts" : posts,
			"my_club_posts":my_club_posts,
			"posts_media" : posts_media,
			"post_comments" : post_comments,
			"media_url" : settings.MEDIA_URL,
			}
	return render(request,'CREW/CA_index.html',dic)

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
		if request.POST.get('s_id'):
			club_selected = request.POST.get('selected_club')
			s_id = request.POST.get('s_id')
			usr = user.objects.get(id = s_id)
			decision = request.POST.get('radio')
			if club_selected!= "" and decision == "agree":
				Club = club.objects.get(club_name = club_selected)
				club_registered_member.objects.create(user_id = usr, club_id = Club)
				return redirect('student',s_id)
			else:
				return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			club_selected = request.POST.get('selected_club')
			ca_id = request.POST.get('ca_id')
			usr = user.objects.get(id = ca_id)
			decision = request.POST.get('radio')
			if club_selected!= "" and decision == "agree":
				Club = club.objects.get(club_name = club_selected)
				club_registered_member.objects.create(user_id = usr, club_id = Club)
				return redirect('Club_Admin',ca_id)
			else:
				return redirect('Club_Admin',ca_id)

def leave_club(request):
	if request.method == 'POST':
		if request.POST.get('s_id'):
			club_left = request.POST['club_left']
			reason_obtained = request.POST['reason']
			s_id = request.POST['s_id']
			print(club_left, reason_obtained)
			clubdata = club.objects.get(club_name = club_left)
			print(clubdata)
			usr = user.objects.get(id = s_id)
			club_registered_member.objects.filter(user_id = usr, club_id = clubdata).delete()
			leave_club_log.objects.create(user_id = usr, club_id=clubdata, reason = reason_obtained)
			return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			club_left = request.POST['club_left']
			reason_obtained = request.POST['reason']
			ca_id = request.POST['ca_id']
			print(club_left, reason_obtained)
			clubdata = club.objects.get(club_name = club_left)
			print(clubdata)
			usr = user.objects.get(id = ca_id)
			club_registered_member.objects.filter(user_id = usr, club_id = clubdata).delete()
			leave_club_log.objects.create(user_id = usr, club_id=clubdata, reason = reason_obtained)
			return redirect('Club_Admin',ca_id)


def create_post(request):
	if request.method == "POST":
		if request.POST.get('s_id'):
			title = request.POST.get('post_title')
			club_name = request.POST.get('Club')
			content = request.POST.get('content')
			File = request.FILES.getlist('File')
			s_id = request.POST.get('s_id')
			usr = user.objects.get(id = s_id)
			Club = club.objects.get(club_name=club_name)
			Post = post.objects.create(club_id = Club, posted_by_id = usr, content = content, post_datetime = datetime.now(), post_title = title)
			for file in File:
				if(file.name.lower().endswith('.png') or file.name.lower().endswith('.jpg') or file.name.lower().endswith('.jpeg') or file.name.lower().endswith('.png')):
					post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
				
			return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			title = request.POST.get('post_title')
			club_name = request.POST.get('Club')
			content = request.POST.get('content')
			File = request.FILES.getlist('File')
			ca_id = request.POST.get('ca_id')
			usr = user.objects.get(id = ca_id)
			Club = club.objects.get(club_name=club_name)
			Post = post.objects.create(club_id = Club, posted_by_id = usr, content = content, post_datetime = datetime.now(), post_title = title)
			for file in File:
				if(file.name.lower().endswith('.png') or file.name.lower().endswith('.jpg') or file.name.lower().endswith('.jpeg') or file.name.lower().endswith('.png')):
					post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
				
			return redirect('Club_Admin',ca_id)
		elif request.POST.get('sa_id'):
			title = request.POST.get('post_title')
			club_name = request.POST.get('Club')
			content = request.POST.get('content')
			File = request.FILES.getlist('File')
			s_id = request.POST.get('sa_id')
			usr = user.objects.get(id = sa_id)
			Club = club.objects.get(club_name=club_name)
			Post = post.objects.create(club_id = Club, posted_by_id = usr, content = content, post_datetime = datetime.now(), post_title = title)
			for file in File:
				if(file.name.lower().endswith('.png') or file.name.lower().endswith('.jpg') or file.name.lower().endswith('.jpeg') or file.name.lower().endswith('.png')):
					post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
				
			return redirect('Super_Admin',sa_id)

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
		if request.POST.get('s_id'):
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
		elif request.POST.get('ca_id'):
			s_id = request.POST.get('ca_id')
			usr = user.objects.get(id = ca_id)
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
		if request.POST.get('ca_id'):
			poll_title = request.POST.get('poll_title')
			poll_description = request.POST.get('poll_description')
			poll_start_datetime = request.POST.get('poll_start')
			poll_end_datetime = request.POST.get('poll_end')
			poll_type = request.POST.get('pollOption_type')
			usr_id = request.POST.get('ca_id')
			usr = user.objects.get(id = usr_id)  
			no_of_options = request.POST.get('no_of_options')
			poll_created = poll.objects.create(poll_title = poll_title, poll_description = poll_description,poll_type = poll_type, user_id = usr,start_datetime = poll_start_datetime,end_datetime = poll_end_datetime)
			for i in range(1,int(no_of_options)+1):
				title_no = "opt"+str(i)+"_title"
				image_no = 'opt'+str(i)+'_img'
				image = request.FILES.getlist(image_no)
				option = request.POST.get(title_no)
				if len(image)!=0:
					for img in image:
						poll_options.objects.create(poll_id = poll_created, option = option, image = img)
				else:
					poll_options.objects.create(poll_id = poll_created, option = option)
			return redirect('Club_Admin',usr_id)
		elif request.POST.get('sa_id'):
			poll_title = request.POST.get('poll_title')
			poll_description = request.POST.get('poll_description')
			poll_start_datetime = request.POST.get('poll_start')
			poll_end_datetime = request.POST.get('poll_end')
			poll_type = request.POST.get('pollOption_type')
			usr_id = request.POST.get('ca_id')
			usr = user.objects.get(id = usr_id)  
			no_of_options = request.POST.get('no_of_options')
			poll_created = poll.objects.create(poll_title = poll_title, poll_description = poll_description,poll_type = poll_type, user_id = usr,start_datetime = poll_start_datetime,end_datetime = poll_end_datetime)
			for i in range(1,int(no_of_options)+1):
				title_no = "opt"+str(i)+"_title"
				image_no = 'opt'+str(i)+'_img'
				image = request.FILES.getlist(image_no)
				option = request.POST.get(title_no)
				if len(image)!=0:
					for img in image:
						poll_options.objects.create(poll_id = poll_created, option = option, image = img)
				else:
					poll_options.objects.create(poll_id = poll_created, option = option)
			return redirect('Club_Admin',usr_id)

@csrf_protect
def participate_poll(request):
	if request.method == "POST":
		s_id = request.POST.get('s_id')
		poll_id = request.POST.get('poll_id')
		Poll = poll.objects.get(id = poll_id)
		Poll_options = request.POST.getlist('poll_'+str(poll_id))
		for option in Poll_options:
			poll_option = poll_options.objects.get(poll_id = Poll, option = option)
			print(poll_option)
			poll_option.votes+=1
			poll_option.save()
		return redirect('student',s_id)
		

def register_event(request):
	if request.method == "POST":
		if request.POST.get('s_id'):
			s_id = request.POST.get('s_id')
			usr = user.objects.get(id = s_id)
			event_selected = request.POST.get('selected_event')
			Event = event.objects.get(event_name = event_selected)
			Event.event_fill_status +=1
			Event.save()
			event_registered_user.objects.create(user_id = usr, event_id = Event)
			return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			ca_id = request.POST.get('ca_id')
			usr = user.objects.get(id = ca_id)
			event_selected = request.POST.get('selected_event')
			Event = event.objects.get(event_name = event_selected)
			Event.event_fill_status +=1
			Event.save()
			event_registered_user.objects.create(user_id = usr, event_id = Event)
			return redirect('Club_Admin',ca_id)

def comments(request):
	if request.method == "POST":
		if request.POST.get('s_id'):
			s_id = request.POST.get('s_id')
			usr = user.objects.get(id = s_id)
			comment_content = request.POST.get('comment_content')
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			comment.objects.create(user_id = usr, content = comment_content, post_id = Post)
			return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			ca_id = request.POST.get('ca_id')
			usr = user.objects.get(id = ca_id)
			comment_content = request.POST.get('comment_content')
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			comment.objects.create(user_id = usr, content = comment_content, post_id = Post)
			return redirect('Club_Admin',ca_id)
		elif request.POST.get('sa_id'):
			sa_id = request.POST.get('sa_id')
			usr = user.objects.get(id = ca_id)
			comment_content = request.POST.get('comment_content')
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			comment.objects.create(user_id = usr, content = comment_content, post_id = Post)
			return redirect('Super_Admin',sa_id)

def like(request):
	if request.method == "POST":
		if request.POST.get('s_id'):
			s_id = request.POST.get('s_id')
			usr = user.objects.get(id = s_id)
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			
			likes.objects.create(post_id = Post, liked_user_id = usr , like_type = 'Like')
			return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			ca_id = request.POST.get('ca_id')
			usr = user.objects.get(id = ca_id)
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			
			likes.objects.create(post_id = Post, liked_user_id = usr , like_type = 'Like')
			return redirect('Club_Admin',ca_id)
		elif request.POST.get('sa_id'):
			sa_id = request.POST.get('sa_id')
			usr = user.objects.get(id = sa_id)
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			
			likes.objects.create(post_id = Post, liked_user_id = usr , like_type = 'Like')
			return redirect('Super_Admin',sa_id)


def dislike(request):
	if request.method == "POST":
		if request.POST.get('s_id'):
			s_id = request.POST.get('s_id')
			usr = user.objects.get(id = s_id)
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			
			likes.objects.create(post_id = Post, liked_user_id = usr , like_type = 'DisLike')
			return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			ca_id = request.POST.get('ca_id')
			usr = user.objects.get(id = ca_id)
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			
			likes.objects.create(post_id = Post, liked_user_id = usr , like_type = 'DisLike')
			return redirect('Club_Admin',ca_id)

		elif request.POST.get('sa_id'):
			sa_id = request.POST.get('sa_id')
			usr = user.objects.get(id = sa_id)
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			
			likes.objects.create(post_id = Post, liked_user_id = usr , like_type = 'DisLike')
			return redirect('Super_Admin',sa_id)

@csrf_protect
def student_profile(request,s_id):
	student_data = user.objects.get(id = s_id)
	print(student_data.user_dp)
	context = {
			"stud":s_id,
			"student_data":student_data,
		}
	return render(request,"CREW/profile_student.html",context)	

		

def events_registered(request):
	if request.method == "POST":
		s_id = request.POST.get('s_id')
		print("s_id")
		usr = user.objects.get(id = s_id)
		events_registered = event_registered_user.objects.filter(user_id = usr)
		print(events_registered)
		context = {
				"stud":usr.id ,
				"events_registered": events_registered,
				"events":event.objects.all(),
				#"events_no":len(events_registered),
				}
		return render(request,'CREW/events_student.html',context)
	

def edit_profile_pic(request):
	if request.method == "POST":
		studentid = request.POST['s_id']
		pic = request.FILES.getlist('pic')
		for img in pic:
			print(img)
			student_data = user.objects.get(id = studentid)
			student_data.user_dp = img
			student_data.save()
		return redirect('student_profile',studentid)

def EditDetails(request):
	if request.method == "POST":
		studentid = request.POST['s_id']
		editName = request.POST['editName']
		UpdateBio = request.POST['BIO']
		print(studentid)
		student_data = user.objects.get(id = studentid)
		print(student_data.user_dp)
		student_data.user_name = editName
		student_data.user_bio = UpdateBio
		student_data.save()
		# context = {
		# 	"student_data":student_data,
		# }
		# print("Hello")
		return redirect('student_profile',studentid)

def DelImage(request):
	if request.method == "POST":
		studentid = request.POST['s_id']
		
		print(studentid)
		student_data = user.objects.get(id = studentid)
		student_data.user_dp = None
		student_data.save()
		# context = {
		# 	"student_data":student_data,
		# }
		# print("Hello")
		return redirect('student_profile',studentid)
		
def postsUploaded(request,s_id):
	usr = user.objects.get(id = s_id)
	UserPosts = post.objects.filter(posted_by_id = usr)
	print(UserPosts)
	context = {
			"stud":usr.id ,
			"UserPosts": UserPosts,
			"clubs":club.objects.all(),
			#"events_no":len(events_registered),
			}
	print(usr.id)
	print("postsUploaded")
	print(usr.id)
	return render(request,'CREW/posts_student.html',context)

def Details(request,s_id,p_id):
	usr = user.objects.get(id = s_id)
	UserPosts = post.objects.get(posted_by_id = usr, id = p_id)
	#print(UserPosts.post_title,UserPosts.content)
	context = {
		'stud':s_id,
		'student_data': usr,
		'UserPosts' : UserPosts,
	}
	print("Details")
	print(usr.id)
	return render(request,'CREW/details.html',context)	

def EditPost(request):
	if request.method == "POST":
		studentid = request.POST['s_id']
		editTitle = request.POST['Title']
		editContent = request.POST['Contents']
		PostId = request.POST['p_id']
		print(studentid)
		EditingPost = post.objects.get(id = PostId)
		#print(student_data.user_dp)
		EditingPost.post_title = editTitle
		EditingPost.content = editContent
		EditingPost.save()
		# print("Hello")
		return redirect('Details',studentid,PostId)

def DelPost(request,s_id,p_id):
	post.objects.get(id = p_id).delete()

	return redirect('postsUploaded',s_id)

def admin_profile(request,sa_id):
	admin_data = user.objects.get(id = sa_id)

		# student_data.user_dp = pic
		# student_data.save()
	print(admin_data)
	context = {
			"user":sa_id,
			"admin_data":admin_data,
		}
	return render(request,"CREW/profile_admin.html",context)	
def all_clubs(request,sa_id):
	clubs = club.objects.all()
	clubAdmins = club.objects.all()
	dic = {
		"user":sa_id,
		"clubs":clubs,
		"clubAdmins":clubAdmins,

	}
	return render(request,'CREW/SA_clubs.html',dic)

def super_admin_posts(request,sa_id):
	usr = user.objects.get(id = sa_id)
	UserPosts = post.objects.filter(posted_by_id = usr)
	print(UserPosts)
	context = {
			"user":sa_id ,
			"UserPosts": UserPosts,
			"clubs":club.objects.all(),
			#"events_no":len(events_registered),
			}
	print(usr.id)
	print("postsUploaded")
	print(usr.id)
	return render(request,'CREW/posts_admin.html',context)
			
def edit_profile_pic_admin(request):
	if request.method == "POST":
		adminid = request.POST['sa_id']
		pic = request.POST['pic']
		print(adminid)
		admin_data = user.objects.get(id = adminid)
		print(admin_data.user_dp)
		admin_data.user_dp = pic
		admin_data.save()
		# context = {
		# 	"student_data":student_data,
		# }
		# print("Hello")
		return redirect('admin_profile',adminid)

def EditDetails_admin(request):
	if request.method == "POST":
		adminid = request.POST['sa_id']
		editName = request.POST['editName']
		UpdateBio = request.POST['BIO']
		print(adminid)
		admin_data = user.objects.get(id = adminid)
		print(admin_data.user_dp)
		admin_data.user_name = editName
		admin_data.user_bio = UpdateBio
		admin_data.save()
		# context = {
		# 	"student_data":student_data,
		# }
		# print("Hello")
		return redirect('admin_profile',adminid)


def DelImage_admin(request):
	if request.method == "POST":
		adminid = request.POST['sa_id']
		
		print(adminid)
		admin_data = user.objects.get(id = adminid)
		admin_data.user_dp = None
		admin_data.save()
		# context = {
		# 	"student_data":student_data,
		# }
		# print("Hello")
		return redirect('admin_profile',adminid)

def club_events_admin(request,sa_id):
	events = event.objects.all()
	context = {
		"user":sa_id,
		"events":events,
	}


	return render(request,'CREW/SA_events.html',context)








