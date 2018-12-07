from django.contrib import admin

from .models import *

admin.site.register(club)
admin.site.register(user)
admin.site.register(event)
admin.site.register(club_admin)
admin.site.register(room)
admin.site.register(post)
admin.site.register(post_media)
admin.site.register(poll)
admin.site.register(poll_participation)
admin.site.register(poll_options)
admin.site.register(event_registered_user)
admin.site.register(club_registered_member)
admin.site.register(notification)
admin.site.register(likes)
admin.site.register(media)
admin.site.register(event_media)
admin.site.register(comment)
admin.site.register(login)
admin.site.register(leave_club_log)
admin.site.register(remove_club_log)
admin.site.register(logout_log)
admin.site.register(notification_user)

