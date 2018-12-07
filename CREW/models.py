from django.db import models
from datetime import datetime
from django.utils import timezone
# Create your models here.

class user(models.Model):
	user_name = models.CharField(max_length=30)
	user_email = models.CharField(max_length=30)
	user_type = models.CharField(max_length=30)
	user_role = models.CharField(max_length=30)
	user_password = models.CharField(max_length=30)
	user_bio = models.TextField(default="user_bior")
	user_dp = models.ImageField(upload_to="users_profile_images",blank=True,null=True)
	def __str__(self):
		return str(self.id)+' '+self.user_name

class club(models.Model):
	club_name = models.CharField(max_length=30)
	club_description = models.TextField()
	club_startdate = models.DateTimeField(default=timezone.now, blank=True)
	club_logo = models.ImageField(blank=True,null=True,upload_to = "club_logos")
	club_tc = models.FileField(blank=False,upload_to="club_t&c")
	club_active_status = models.BooleanField(default=True)
	def __str__(self):
		return "Club id :" + str(self.id) + ' '+str(self.club_name) + ' ' + str(self.club_active_status)

class club_admin(models.Model):
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	club_id = models.ForeignKey(club,on_delete=models.CASCADE)
	date_of_joining = models.DateTimeField(default=timezone.now, blank=True)
	def __str__(self):
		return str(self.club_id) +  " user-id "+ str(self.user_id)

class club_registered_member(models.Model):
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	club_id = models.ForeignKey(club,on_delete=models.CASCADE)
	date_of_joining = models.DateTimeField(default=timezone.now, blank=True)
	def __str__(self):
		return "Registration " + str(self.club_id) +  " user-id "+ str(self.user_id)		

class room(models.Model):
	timestamp = models.DateTimeField(default=timezone.now, blank=True)
	room_num = models.IntegerField(default=0)
	room_capacity =  models.IntegerField(default=1)
	def __str__(self):
		return "Room No - " + str(self.room_num)

		
class event(models.Model):
	event_name = models.CharField(max_length=30)
	event_start_datetime = models.DateTimeField(default=timezone.now, blank=True)
	event_end_datetime = models.DateTimeField(default=timezone.now, blank=True)
	event_type = models.CharField(max_length=30)
	event_duration = models.IntegerField(default=0)
	event_host = models.CharField(max_length=30)
	event_limit = models.IntegerField(default=0)
	event_fill_status = models.IntegerField(default=0)
	organizer_id = models.ForeignKey(user,on_delete=models.CASCADE)
	club_id = models.ForeignKey(club,on_delete=models.CASCADE)
	event_venue = models.ForeignKey(room,on_delete=models.CASCADE) # CHECK THIS #
	
	def __str__(self):
		return str(self.id)+" " + self.event_name

class event_registered_user(models.Model):
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	event_id = models.ForeignKey(event,on_delete=models.CASCADE)
	register_datetime = models.DateTimeField(default=timezone.now, blank=True)
	def __str__(self):
		return "Event : " + str(self.event_id) + " User :"+ str(self.user_id)

class event_media(models.Model):
	event_id = models.ForeignKey(event,on_delete=models.CASCADE)
	media_type = models.CharField(max_length = 30)
	media = models.FileField(upload_to = "event_media",blank=True)
	def __str__(self):
		return str(self.event_id) + self.media_type

class notification(models.Model):
	club_id = models.ForeignKey(club,on_delete=models.CASCADE)
	notification_content = models.TextField()
	notification_datetime = models.DateTimeField(default=timezone.now, blank=True)
	def __str__(self):
		return "Notif :" + str(self.id)

class post(models.Model):
	post_title = models.CharField(max_length = 50)
	club_id = models.ForeignKey(club,on_delete=models.CASCADE)
	posted_by_id = models.ForeignKey(user,on_delete=models.CASCADE)
	content = models.TextField()
	post_datetime = models.DateTimeField(default=timezone.now, blank=True)
	def __str__(self):
		return "Post :" + str(self.id) + ' ' + self.post_title
 
class post_media(models.Model):
	post_id = models.ForeignKey(post,on_delete=models.CASCADE)
	post_type = models.CharField(max_length=30)
	media = models.FileField(upload_to="post_media", blank = False)
	def __str__(self):
		return str(self.post_id) + self.post_type

class comment(models.Model):
	post_id = models.ForeignKey(post,on_delete=models.CASCADE)
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	content = models.TextField()
	comment_datetime = models.DateTimeField(default=timezone.now, blank=True)
	def __str__(self):
		return "Comment :" + str(self.id)

class likes(models.Model):
	post_id = models.ForeignKey(post,on_delete=models.CASCADE)
	liked_user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	like_type = models.CharField(max_length=30)
	def __str__(self):
		return "Post: " + str(self.post_id) + self.like_type +"d by" + str(self.liked_user_id) 

class poll(models.Model):
	poll_title = models.CharField(max_length=50)
	poll_description = models.TextField()
	poll_winner = models.IntegerField(default=1)
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	start_datetime = models.DateTimeField(default=timezone.now, blank=True)
	end_datetime = models.DateTimeField(default=timezone.now, blank=True)
	poll_type = models.CharField(max_length=10)
	def __str__(self):
		return str(self.id) + self.poll_title

class poll_options(models.Model):
	poll_id = models.ForeignKey(poll,on_delete=models.CASCADE)
	option = models.CharField(max_length=30)
	image = models.ImageField(upload_to="poll_media/polls",blank=True)
	votes = models.IntegerField(default=0)
	def __str__(self):
		return "Poll - "+ str(self.poll_id) +" option - " +str(self.id)

class poll_participation(models.Model):
	poll_id = models.ForeignKey(poll,on_delete=models.CASCADE)
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	option_id = models.ForeignKey(poll_options,on_delete=models.CASCADE)
	def __str__(self):
		return "Poll - "+ str(self.poll_id) + "By user -"+ str(self.user_id) +" option - " +str(self.option_id)

class media(models.Model):
	media = models.FileField()
	media_type = models.CharField(max_length=30)
	club_id = models.ForeignKey(club,on_delete=models.CASCADE)
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	def __str__(self):
		return str(self.id)+media_type+ "club - "+str(self.club_id) + "user - " +str(self.user_id)

class login(models.Model):
	login_id = models.IntegerField(default=1)
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	datetime_of_login = models.DateTimeField(default=timezone.now, blank=True)
	def __str__(self):
		return "At "+ str(self.datetime_of_login) + " by user "+str(self.user_id)

class leave_club_log(models.Model):
	leave_club_id = models.IntegerField(default=1)
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	club_id = models.ForeignKey(club,on_delete=models.CASCADE)
	date_of_leaving = models.DateTimeField(default=timezone.now)
	reason = models.TextField()
	def __str__(self):
		return "At "+ str(self.date_of_leaving) + " by user "+str(self.user_id)

class logout_log(models.Model):
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	logout_datetime = models.DateTimeField(default=timezone.now)
	def __str__(self):
		return "At " + str(self.logout_datetime) + " by user " + str(self.user_id)

class remove_club_log(models.Model):
	club_id = models.ForeignKey(club,on_delete=models.CASCADE)
	remove_datetime = models.DateTimeField(default=timezone.now)
	def __str__(self):
		return "Club" + self.club_id + "removed at" + str(self.remove_datetime)

class notification_user(models.Model):
	user_id = models.ForeignKey(user,on_delete=models.CASCADE)
	notification_id = models.ForeignKey(notification,on_delete=models.CASCADE)
	view_type = models.BooleanField(default=False)

	def __str__(self):
		if(self.view_type==0):
			return "Notification " + str(self.notification_id) + "Unseen by user" + str(self.user_id)
		elif(self.view_type==1):
			return "Notification " + str(self.notification_id) + "Seen by user" + str(self.user_id)