from django.shortcuts import render
from django.template import loader
from django.http import HttpResponse
from django.shortcuts import redirect
from .models import *
import urllib
from datetime import datetime
from django.views.decorators.csrf import *
from django.urls import reverse
from django.db.models import F,Q
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
				return render(request,'CREW/login.html',{'error':"Incorrect credentials"})
		else:
			return render(request,'CREW/login.html',{'error':"Incorrect credentials"})

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
'''def get_callback(request):
	url = "https://serene-wildwood-35121.herokuapp.com/oauth/changeUrl"
	Payload = { 'clientId': "5bd4a72c4789560015311a2c",
	 			'secret': "1c7bfdbc537818fc991f5b014c37632c8a1724e224f3725c1138ccd649f4892e9bf4a1824ccdeffd66cd8df9e8741eb0887d8ae1679c8ccc3f9e6692590dba95", 
				'url':"http://10.0.51.140:8000/dashboard/"
			}
	p = request.POST(url,Payload)
	url_details = json.loads(p.content)
	print(url_details)
	print(1)
	return 1'''




# Student Functionalities

def student(request,s_id):

	# Check if he is student actually
	usr = user.objects.get(id = s_id)
	
	clubs_joined = set(club_registered_member.objects.filter(user_id = usr).values_list('club_id',flat=True))
	clubs = set(club.objects.all().values_list('id',flat=True))
	clubs_remaining = list(clubs - clubs_joined)
	clubs_remain = club.objects.filter(id__in = clubs_remaining).order_by('club_name')
	clubs_remain = clubs_remain.exclude(club_active_status = False)
	
	myposts_count = post.objects.filter(posted_by_id = usr).count()
	new_notification_ids = list(notification_user.objects.filter(user_id = s_id, view_type = False).values_list('notification_id',flat=True))
	new_notifications_to_show = notification.objects.filter(id__in = new_notification_ids).order_by('notification_datetime')
	old_notification_ids = list(notification_user.objects.filter(user_id = s_id, view_type = True).values_list('notification_id',flat=True))
	old_notifications_to_show = notification.objects.filter(id__in = old_notification_ids).order_by('notification_datetime')
	
	
	posts_clubs = list(clubs_joined) + list(club.objects.filter(club_name = "Universal").values_list('id',flat=True))
	posts = post.objects.filter(club_id__in = posts_clubs).order_by('-post_datetime')
	my_posts = post.objects.filter(posted_by_id = usr).order_by('-post_datetime')
	post_ids = list(posts.values_list('id',flat=True))+list(my_posts.values_list('id',flat=True))
	posts_media = post_media.objects.filter(post_id__in = post_ids)
	post_comments = comment.objects.filter(post_id__in = post_ids).order_by('-comment_datetime')
	
	my_posts = post
	
	#events_of_clubs_in = event.objects.filter(club_id__in = list(clubs_joined)).exclude(event_fill_status=F('event_limit'))
	events_registered = list(event_registered_user.objects.filter(user_id = usr).values_list('event_id',flat=True))

	# send all the events irrespective of he/she being in the club or not
	
	# Assuming : Once the event starts, the registrations are closed
	today = datetime.today()
	
	#events which didn't start yet
	events = event.objects.all().exclude(id__in = events_registered,event_fill_status=F('event_limit')).filter(Q(event_start_datetime__gte=today))
	event_ids = list(events.values_list('id',flat=True))
	events_media = event_media.objects.filter(event_id__in = event_ids)
	#no_events = len(events_ids)


	#select polls only of those clubs user is in and also from super admin
	super_admin_id = list(user.objects.filter(user_type = "Super Admin").values_list('id',flat=True))
	joinedClubs_admin_ids = list(club_admin.objects.filter(club_id__in = clubs_joined).values_list('user_id',flat=True))
	
	posting_user_ids = joinedClubs_admin_ids + super_admin_id
	
	polls_participated = list(poll_participation.objects.filter(user_id = usr).values_list('poll_id',flat=True))
	polls = poll.objects.filter(user_id__in = posting_user_ids) #getting polls related to his clubs/superadmin
	polls = polls.exclude(id__in = polls_participated) # Excluding polls already participated in
	polls = polls.filter(Q(end_datetime__gte=today))#.filter(Q(start_datetime__lte=today))

	finished_polls = poll.objects.filter(Q(end_datetime__lte=today))
	Club = club.objects.get(club_name = "Universal")

	for Poll in finished_polls:
		mx = -1
		winner = 0
		options = poll_options.objects.filter(poll_id = Poll)
		content =  Poll.poll_title + " poll is over. The votes are as follows :\n"
		for opt in options:
			if(opt.votes>mx):
				mx = opt.votes
				winner = opt.id
			content += str(opt.option)+" : "+str(opt.votes)+"\n"
		Poll.poll_winner = winner
		content+="\n And the winner of the poll is : "+"option "+str(winner)+"."


		new_notification = notification.objects.create(club_id = Club , notification_content=content)
		usersToBeNotified = user.objects.all()
	
		for usr in usersToBeNotified:
			notification_user.objects.create(user_id = usr , notification_id = new_notification)		



	poll_ids = list(polls.values_list('id',flat=True))
	no_of_polls = polls.count()


	
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
			}
	return render(request,'CREW/student_index.html',dic)

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


@csrf_protect
def participate_poll(request):
	if request.method == "POST":
		s_id = request.POST.get('s_id')
		usr = user.objects.get(id = s_id)
		poll_ids = eval(request.POST.get('votes'))

		for poll_id in poll_ids:
			Poll = poll.objects.get(id = poll_id)
			Poll_options = request.POST.getlist(str(poll_id))
			for option in Poll_options:
				poll_option = poll_options.objects.get(poll_id = Poll, option = option)
				poll_option.votes+=1
				poll_option.save()
				poll_participation.objects.create(poll_id = Poll , user_id = usr , option_id = poll_option)
		
		return redirect('student',s_id)

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


# Club Admin Functionalities
def Club_Admin(request,ca_id):
	usr = user.objects.get(id = ca_id)
	for_club = (club_admin.objects.filter(user_id = usr).values_list('club_id',flat=True))[0]
	Club = club.objects.get(id = for_club)
	no_of_students = club_registered_member.objects.filter(club_id = Club)


	clubs_joined = set(club_registered_member.objects.filter(user_id = usr).values_list('club_id',flat=True))
	clubs = set(club.objects.all().values_list('id',flat=True))
	clubs_remaining = list(clubs - clubs_joined)
	clubs_remain = club.objects.filter(id__in = clubs_remaining).order_by('club_name')
	clubs_remain = clubs_remain.exclude(club_active_status = False)
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
	posts = post.objects.filter(club_id__in = clubs_joined).exclude(posted_by_id = usr).order_by('-post_datetime')
	posts_clubs = list(clubs_joined) + list(club.objects.filter(club_name = "Universal").values_list('id',flat=True))
	posts = post.objects.filter(club_id__in = posts_clubs).order_by('-post_datetime')


	my_posts = post.objects.filter(posted_by_id = usr).order_by('-post_datetime')
	post_ids = list(posts.values_list('id',flat=True))+list(my_posts.values_list('id',flat=True))
	posts_media = post_media.objects.filter(post_id__in = post_ids)
	post_comments = comment.objects.filter(post_id__in = post_ids).order_by('-comment_datetime')	
	
	my_likes = likes.objects.filter(liked_user_id = usr)
	events_organized = event.objects.filter(club_id = Club)

	rooms = room.objects.all()
	
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
			"my_posts":my_posts,
			"my_likes":my_likes,
			"posts_media" : posts_media,
			"post_comments" : post_comments,
			"media_url" : settings.MEDIA_URL,
			"rooms":rooms,
			"post_clubs":posts_clubs,
			}
	return render(request,'CREW/CA_index.html',dic)

def club_admin_profile(request,ca_id):
	club_admin_data = user.objects.get(id = ca_id)
	context = {
			"user":ca_id,
			"club_admin_data":club_admin_data,
		}
	return render(request,"CREW/profile_admin.html",context)

def Students_in_Club(request):
	if request.method == "POST":
		ca_id = request.POST['ca_id']
		club_admin_data = user.objects.get(id = ca_id)
		#clubs = club.objects.all()
		club_id = club_admin.objects.get(user_id = club_admin_data)
		club_members = list(club_registered_member.objects.filter(club_id= club_id.id).values_list('user_id','date_of_joining'))
		club_members_date = list(club_registered_member.objects.filter(club_id= club_id.id).values_list('date_of_joining',flat=True))
		students = user.objects.all() 
		clubs_joined = club_registered_member.objects.filter(user_id = ca_id)
		clubs = club.objects.all()
		
		dic = {
			"user":club_admin_data,
			"students":students,
			"club_members":club_members,
			"club_members_date":club_members_date,
			"club_id":club_id,
			"clubs_joined":clubs_joined,
			"clubs":clubs,
		}
	return render(request,'CREW/club_students.html',dic)

def CA_events(request):
	if request.method == "POST":
		ca_id = request.POST['ca_id']
		events = list(event.objects.filter(organizer_id = ca_id).values_list('id','event_name','event_start_datetime'))
		context = {
			"user":ca_id,
			"events":events,
		}


		return render(request,'CREW/events_admin.html',context)

def EditDetails_club_admin(request):
	if request.method == "POST":
		ca_id = request.POST['ca_id']
		editName = request.POST['editName']
		UpdateBio = request.POST['BIO']
		club_admin_data = user.objects.get(id = ca_id)
		club_admin_data.user_name = editName
		club_admin_data.user_bio = UpdateBio
		club_admin_data.save()
		return redirect('club_admin_profile',ca_id)

def EditDP_club_admin(request):
	if request.method == "POST":
		ca_id = request.POST['ca_id']
		pic = request.FILES.getlist('pic')
		for img in pic:
			club_admin_data = user.objects.get(id = ca_id)
			club_admin_data.user_dp = img
			club_admin_data.save()
		return redirect('club_admin_profile',ca_id)

def DelImage_club_admin(request):
	if request.method == "POST":
		ca_id = request.POST['ca_id']
		club_admin_data = user.objects.get(id = ca_id)
		club_admin_data.user_dp = None
		club_admin_data.save()
		return redirect('club_admin_profile',ca_id)

def club_admin_posts(request,ca_id):
	usr = user.objects.get(id = ca_id)
	UserPosts = post.objects.filter(posted_by_id = usr)
	print(UserPosts)
	context = {
			"Data":usr,
			"user":ca_id ,
			"UserPosts": UserPosts,
			"clubs":club.objects.all(),
			}
	print(usr.id)
	print("postsUploaded")
	print(usr.id)
	return render(request,'CREW/posts_admin.html',context)

def CA_post_Details(request,ca_id,p_id):
	usr = user.objects.get(id = ca_id)
	UserPosts = post.objects.get(posted_by_id = usr, id = p_id)
	#print(UserPosts.post_title,UserPosts.content)
	context = {
		'user':ca_id,
		'student_data': usr,
		'UserPosts' : UserPosts,
	}
	#print("Details")
	print(usr.id)
	return render(request,'CREW/CA_post_Details.html',context)

def CA_EditPost(request):
	if request.method == "POST":
		ca_id = request.POST['ca_id']
		editTitle = request.POST['Title']
		editContent = request.POST['Contents']
		PostId = request.POST['p_id']
		Post = post.objects.get(id = PostId)
		files = request.FILES.getlist('editPost_files')
		
		EditingPost = post.objects.get(id = PostId)
		EditingPost.post_title = editTitle
		EditingPost.content = editContent
		EditingPost.save()
		
		print("Post")
		try:
			post_media.objects.get(post_id = Post).delete()
		except:
			print("No media for the post")
		
		print(files)
		for file in files:
			print(file)
			if(file.name.lower().endswith(('.png','.jpg','.jpeg','.gif','.tiff','.svg'))):
				print("In if")
				post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
			elif(file.name.lower().endswith(('.flv','.avi','.mov','mp4','.mpg','.wmv','.asf','.3gp','.swf','.rm'))):
				post_media.objects.create(post_id = Post ,post_type = "Video", media = file)
			elif(file.name.lower().endswith(('.pdf','.doc','.docx','.html','.htm','.txt'))):
				post_media.objects.create(post_id = Post ,post_type = "Document", media = file)
		
		return redirect('CA_post_Details',ca_id,PostId)

def CA_DelPost(request,ca_id,p_id):
	post.objects.get(id = p_id).delete()

	return redirect('club_admin_posts',ca_id)


	


# Super Admin Functionalities
def Super_Admin(request,sa_id):
	usr = user.objects.get(id = sa_id)
	total_clubs = club.objects.all().count()
	all_clubs = club.objects.all()
	myposts_count = post.objects.filter(posted_by_id = usr).count()
	event_count = event.objects.all().count()

	new_notification_ids = list(notification_user.objects.filter(user_id = usr, view_type = False).values_list('notification_id',flat=True))
	new_notifications_to_show = notification.objects.filter(id__in = new_notification_ids).order_by('notification_datetime')
	old_notification_ids = list(notification_user.objects.filter(user_id = usr, view_type = True).values_list('notification_id',flat=True))
	old_notifications_to_show = notification.objects.filter(id__in = old_notification_ids).order_by('notification_datetime')



	posts = post.objects.all().exclude(posted_by_id = usr).order_by('-post_datetime')
	my_posts = post.objects.filter(posted_by_id = usr).order_by('-post_datetime')
	post_ids = list(posts.values_list('id',flat=True))+list(my_posts.values_list('id',flat=True))
	posts_media = post_media.objects.filter(post_id__in = post_ids)
	post_comments = comment.objects.filter(post_id__in = post_ids).order_by('-comment_datetime')	
	
	my_likes = likes.objects.filter(liked_user_id = usr)
	

	rooms = room.objects.all()
	
	dic = {
			"user":usr ,
			"clubs_no":total_clubs,
			"myposts_count": myposts_count,
			"all_clubs": all_clubs,
			"events_no":event_count,
			"new_notifications" : new_notifications_to_show,
			"new_notif_no": new_notifications_to_show.count(),
			"old_notifications" : old_notifications_to_show,
			"posts" : posts,
			"my_posts":my_posts,
			"my_likes":my_likes,
			"posts_media" : posts_media,
			"post_comments" : post_comments,
			"media_url" : settings.MEDIA_URL,
			"rooms":rooms,
			}
	return render(request,'CREW/SA_index.html',dic)

def add_club(request):
	if request.method == "POST":
		sa_id = request.POST.get('sa_id')
		club_name = request.POST.get('club_name')
		description = request.POST.get('description')
		tc_doc = request.FILES['tc_doc']
		club_icon = request.FILES['club_icon']
		created_club = club.objects.create(club_name = club_name, club_description = description, club_tc = tc_doc, club_logo = club_icon)
		if("club" in club_name):
			content = club_name + " club is added."
		else:
			content = club_name + " is added."
		
		new_notification = notification.objects.create(club_id = created_club , notification_content=content)
		
		usersToBeNotified = user.objects.all().exclude(id = sa_id)
		
		for usr in usersToBeNotified:
			 notification_user.objects.create(user_id = usr , notification_id = new_notification)
		return redirect('Super_Admin',sa_id)

def remove_club(request):
	if request.method == "POST":
		sa_id = request.POST.get('sa_id')
		club_name = request.POST.get('club_removed')
		club_to_be_removed = club.objects.get(club_name = club_name)
		club_to_be_removed.club_active_status = False
		club_to_be_removed.save()
		content = club_name + " club is removed."

		new_notification = notification.objects.create(club_id = club_to_be_removed , notification_content=content)
		usersToBeNotified = user.objects.all().exclude(id = sa_id)
		
		for usr in usersToBeNotified:
			 notification_user.objects.create(user_id = usr , notification_id = new_notification)		
		return redirect('Super_Admin',sa_id)

def super_admin_posts(request,sa_id):
	usr = user.objects.get(id = sa_id)
	UserPosts = post.objects.filter(posted_by_id = usr)
	print(UserPosts)
	context = {
			"Data":usr,
			"user":sa_id ,
			"UserPosts": UserPosts,
			"clubs":club.objects.all(),
			}
	print(usr.id)
	print("postsUploaded")
	print(usr.id)
	return render(request,'CREW/SA_posts.html',context)

def super_admin_profile(request,sa_id):
	admin_data = user.objects.get(id = sa_id)
	context = {
			"user":sa_id,
			"admin_data":admin_data,
		}
	return render(request,"CREW/SA_profile.html",context)	

def SA_post_Details(request,sa_id,p_id):
	usr = user.objects.get(id = sa_id)
	UserPosts = post.objects.get(posted_by_id = usr, id = p_id)
	#print(UserPosts.post_title,UserPosts.content)
	context = {
		'user':sa_id,
		'student_data': usr,
		'UserPosts' : UserPosts,
	}
	#print("Details")
	print(usr.id)
	return render(request,'CREW/SA_post_Details.html',context)

def SA_EditPost(request):
	if request.method == "POST":
		sa_id = request.POST['sa_id']
		editTitle = request.POST['Title']
		editContent = request.POST['Contents']
		PostId = request.POST['p_id']
		Post = post.objects.get(id = PostId)
		files = request.FILES.getlist('editPost_files')
		EditingPost = post.objects.get(id = PostId)
		EditingPost.post_title = editTitle
		EditingPost.content = editContent
		EditingPost.save()
		# print("Hello")
		
		
		try:
			post_media.objects.get(post_id = Post).delete()
		except:
			print("No media for the post")
		
		
		for file in files:
			print(file)
			if(file.name.lower().endswith(('.png','.jpg','.jpeg','.gif','.tiff','.svg'))):
				print("In if")
				post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
			elif(file.name.lower().endswith(('.flv','.avi','.mov','mp4','.mpg','.wmv','.asf','.3gp','.swf','.rm'))):
				post_media.objects.create(post_id = Post ,post_type = "Video", media = file)
			elif(file.name.lower().endswith(('.pdf','.doc','.docx','.html','.htm','.txt'))):
				post_media.objects.create(post_id = Post ,post_type = "Document", media = file)
		
		return redirect('SA_post_Details',sa_id,PostId)

def SA_DelPost(request,sa_id,p_id):
	post.objects.get(id = p_id).delete()

	return redirect('super_admin_posts',sa_id)
			
def EditDP_super_admin(request):
	if request.method == "POST":
		adminid = request.POST['sa_id']
		pic = request.FILES.getlist('pic')
		for img in pic:
			super_admin_data = user.objects.get(id = adminid)
			super_admin_data.user_dp = img
			super_admin_data.save()
		# pic = request.POST['pic']
		# print(adminid)
		# admin_data = user.objects.get(id = adminid)
		# print(admin_data.user_dp)
		# admin_data.user_dp = pic
		# admin_data.save()
		# context = {
		# 	"student_data":student_data,
		# }
		# print("Hello")
		return redirect('super_admin_profile',adminid)

def EditDetails_super_admin(request):
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
		return redirect('super_admin_profile',adminid)

def DelImage_super_admin(request):
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
		return redirect('super_admin_profile',adminid)

def SA_events(request):
	if request.method == "POST":
		sa_id = request.POST['sa_id']
		#events = event.objects.filter(Q(event_start_datetime__gte = today))
		events = event.objects.all().order_by('-event_end_datetime')
		event_count = events.count()
		context = {
			"user":sa_id,
			"events":events,
			"event_count":event_count,
		}


		return render(request,'CREW/SA_events.html',context)

def SA_clubs(request):
	if request.method =="POST":
		sa_id = request.POST.get('sa_id')
		usr = user.objects.get(id = sa_id)
		clubs_Admin = club_admin.objects.all()
		clubs = club.objects.all()
		admin_users = user.objects.all()
		inactive_clubs = club.objects.filter(club_active_status = False)
		active_clubs = club.objects.filter(club_active_status = True)
		dic = {
				"id":usr.id,
				"clubs_Admin":clubs_Admin,
				"clubs":clubs,
				"admin_users":admin_users,
				"inactive_clubs":inactive_clubs,
				"active_clubs":active_clubs,
				#"events_no":len(events_registered),
			}
		return render(request,'CREW/SA_clubs.html',dic)



# Common Functionalities
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

@csrf_protect
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
			print(File)
			
			for file in File:
				if(file.name.lower().endswith(('.png','.jpg','.jpeg','.gif','.tiff','.svg'))):
					post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
				elif(file.name.lower().endswith(('.flv','.avi','.mov','mp4','.mpg','.wmv','.asf','.3gp','.swf','.rm'))):
					post_media.objects.create(post_id = Post ,post_type = "Video", media = file)
				elif(file.name.lower().endswith(('.pdf','.doc','.docx','.html','.htm','.txt'))):
					post_media.objects.create(post_id = Post ,post_type = "Document", media = file)
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
				if(file.name.lower().endswith(('.png','.jpg','.jpeg','.gif','.tiff','.svg'))):
					post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
				elif(file.name.lower().endswith(('.flv','.avi','.mov','mp4','.mpg','.wmv','.asf','.3gp','.swf','.rm'))):
					post_media.objects.create(post_id = Post ,post_type = "Video", media = file)
				elif(file.name.lower().endswith(('.pdf','.doc','.docx','.html','.htm','.txt'))):
					post_media.objects.create(post_id = Post ,post_type = "Document", media = file)
				
			return redirect('Club_Admin',ca_id)
		elif request.POST.get('sa_id'):
			title = request.POST.get('post_title')
			content = request.POST.get('content')
			File = request.FILES.getlist('File')
			sa_id = request.POST.get('sa_id')
			usr = user.objects.get(id = sa_id)
			Club = club_admin.objects.get(user_id = usr)
			Club = club.objects.get(id = Club.club_id.id)

			
			Post = post.objects.create(club_id = Club, posted_by_id = usr, content = content, post_datetime = datetime.now(), post_title = title)
			for file in File:
				if(file.name.lower().endswith(('.png','.jpg','.jpeg','.gif','.tiff','.svg'))):
					post_media.objects.create(post_id = Post ,post_type = "Image", media = file)
				elif(file.name.lower().endswith(('.flv','.avi','.mov','mp4','.mpg','.wmv','.asf','.3gp','.swf','.rm'))):
					post_media.objects.create(post_id = Post ,post_type = "Video", media = file)
				elif(file.name.lower().endswith(('.pdf','.doc','.docx','.html','.htm','.txt'))):
					post_media.objects.create(post_id = Post ,post_type = "Document", media = file)
				
			return redirect('Super_Admin',sa_id)

def organize_event(request):
	if request.method == 'POST':
		if request.POST.get('ca_id'):
			ca_id = request.POST.get('ca_id')
			organizer = user.objects.get(id = ca_id)
			r_no = int(request.POST.get('room'))
			Room = room.objects.get(room_num = r_no)
			Club_name = request.POST.get('Club')
			Club = club.objects.get(club_name = Club_name)
			

			name = request.POST.get('event_title')
			description = request.POST.get('event_description')
			start_datetime = request.POST.get('start_datetime')
			end_datetime = request.POST.get('end_datetime')
			event_type = request.POST.get('type')
			host = request.POST.get('host')
			limit = request.POST.get('limit')
			duration = request.POST.get('duration')
			Event = event.objects.create(club_id = Club ,event_name = name, event_description=description ,event_start_datetime =start_datetime,event_end_datetime = end_datetime ,event_venue = Room, event_type=event_type,organizer_id = organizer,event_host = host,event_limit = limit,event_duration = duration)
			event_files = request.FILES.getlist('event_media')
			
			for file in event_files:	
				if(file.name.lower().endswith(('.png','.jpg','.jpeg','.gif','.tiff','.svg'))):
					media = event_media.objects.create(event_id=Event,media_type="Image",media=file)
				elif(file.name.lower().endswith(('.flv','.avi','.mov','mp4','.mpg','.wmv','.asf','.3gp','.swf','.rm'))):
					media = event_media.objects.create(event_id=Event,media_type="Video",media=file)
				elif(file.name.lower().endswith(('.pdf','.doc','.docx','.html','.htm','.txt'))):
					media = event_media.objects.create(event_id=Event,media_type="Document",media=file)

				
			
			content =  name + " event is added."
			new_notification = notification.objects.create(club_id = Club , notification_content=content)
			usersToBeNotified = user.objects.all().exclude(id = ca_id)
		
			for usr in usersToBeNotified:
				notification_user.objects.create(user_id = usr , notification_id = new_notification)


			return redirect('Club_Admin',ca_id)
	
		elif request.POST.get('sa_id'):
			sa_id = request.POST.get('sa_id')
			usr = user.objects.get(id = sa_id)
			r_no = int(request.POST.get('room'))
			Room = room.objects.get(room_num = r_no)

			Club = club_admin.objects.get(user_id = usr)
			Club = club.objects.get(id = Club.club_id.id)
			

			name = request.POST.get('event_title')
			description = request.POST.get('event_description')
			start_datetime = request.POST.get('start_datetime')
			end_datetime = request.POST.get('end_datetime')
			event_type = request.POST.get('type')
			host = request.POST.get('host')
			limit = request.POST.get('limit')
			duration = request.POST.get('duration')
			Event = event.objects.create(club_id = Club ,event_name = name, event_description=description ,event_start_datetime =start_datetime,event_end_datetime = end_datetime ,event_venue = Room, event_type=event_type,organizer_id = organizer,event_host = host,event_limit = limit,event_duration = duration)
			event_files = request.FILES.getlist('event_media')
			
			for file in event_files:	
				if(file.name.lower().endswith(('.png','.jpg','.jpeg','.gif','.tiff','.svg'))):
					media = event_media.objects.create(event_id=Event,media_type="Image",media=file)
				elif(file.name.lower().endswith(('.flv','.avi','.mov','mp4','.mpg','.wmv','.asf','.3gp','.swf','.rm'))):
					media = event_media.objects.create(event_id=Event,media_type="Video",media=file)
				elif(file.name.lower().endswith(('.pdf','.doc','.docx','.html','.htm','.txt'))):
					media = event_media.objects.create(event_id=Event,media_type="Document",media=file)
			
			content = name + " event is added."
			new_notification = notification.objects.create(club_id = Club , notification_content=content)
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
			usr_id = request.POST.get('sa_id')
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
			return redirect('Super_Admin',usr_id)

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
		print("In like",request.POST.get('s_id'))
		if request.POST.get('s_id'):
			s_id = request.POST.get('s_id')
			usr = user.objects.get(id = s_id)
			post_id = request.POST.get('post_id')
			Post = post.objects.get(id = post_id)
			
			likes.objects.create(post_id = Post, liked_user_id = usr , like_type = 'Like')
			return redirect('student',s_id)
		elif request.POST.get('ca_id'):
			print("in elif")
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




			
	
