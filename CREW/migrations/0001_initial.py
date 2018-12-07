# Generated by Django 2.1.2 on 2018-11-09 09:00

from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='club',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('club_name', models.CharField(max_length=30)),
                ('club_description', models.TextField()),
                ('club_startdate', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('club_logo', models.ImageField(blank=True, null=True, upload_to='club_logos')),
                ('club_tc', models.FileField(upload_to='club_t&c')),
            ],
        ),
        migrations.CreateModel(
            name='club_admin',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_of_joining', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='club_registered_member',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_of_joining', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='comment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField()),
                ('comment_datetime', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
            ],
        ),
        migrations.CreateModel(
            name='event',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('event_name', models.CharField(max_length=30)),
                ('event_start_datetime', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('event_end_datetime', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('event_type', models.CharField(max_length=30)),
                ('event_duration', models.IntegerField(default=0)),
                ('event_host', models.CharField(max_length=30)),
                ('event_limit', models.IntegerField(default=0)),
                ('event_fill_status', models.IntegerField(default=0)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='event_media',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('media_type', models.CharField(max_length=30)),
                ('media', models.FileField(blank=True, upload_to='event_media')),
                ('event_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.event')),
            ],
        ),
        migrations.CreateModel(
            name='event_registered_user',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('register_datetime', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('event_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.event')),
            ],
        ),
        migrations.CreateModel(
            name='leave_club_log',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('leave_club_id', models.IntegerField(default=1)),
                ('date_of_leaving', models.DateTimeField(default=django.utils.timezone.now)),
                ('reason', models.TextField()),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='likes',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('like_type', models.CharField(max_length=30)),
            ],
        ),
        migrations.CreateModel(
            name='login',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('login_id', models.IntegerField(default=1)),
                ('datetime_of_login', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
            ],
        ),
        migrations.CreateModel(
            name='logout_log',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('logout_datetime', models.DateTimeField(default=django.utils.timezone.now)),
            ],
        ),
        migrations.CreateModel(
            name='media',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('media', models.FileField(upload_to='')),
                ('media_type', models.CharField(max_length=30)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='notification',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('notification_content', models.TextField()),
                ('notification_datetime', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='notification_user',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('view_type', models.BooleanField(default=False)),
                ('notification_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.notification')),
            ],
        ),
        migrations.CreateModel(
            name='poll',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('poll_title', models.CharField(max_length=50)),
                ('poll_description', models.TextField()),
                ('poll_winner', models.IntegerField(default=1)),
                ('start_datetime', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('end_datetime', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('poll_type', models.CharField(max_length=10)),
            ],
        ),
        migrations.CreateModel(
            name='poll_options',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('option', models.CharField(max_length=30)),
                ('image', models.ImageField(blank=True, upload_to='poll_media/polls')),
                ('votes', models.IntegerField(default=0)),
                ('poll_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.poll')),
            ],
        ),
        migrations.CreateModel(
            name='poll_participation',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('option_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.poll_options')),
                ('poll_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.poll')),
            ],
        ),
        migrations.CreateModel(
            name='post',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('post_title', models.CharField(max_length=50)),
                ('content', models.TextField()),
                ('post_datetime', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='post_media',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('post_type', models.CharField(max_length=30)),
                ('media', models.FileField(upload_to='post_media')),
                ('post_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.post')),
            ],
        ),
        migrations.CreateModel(
            name='remove_club_log',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('remove_datetime', models.DateTimeField(default=django.utils.timezone.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='room',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('timestamp', models.DateTimeField(blank=True, default=django.utils.timezone.now)),
                ('room_num', models.IntegerField(default=0)),
                ('room_capacity', models.IntegerField(default=1)),
            ],
        ),
        migrations.CreateModel(
            name='user',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_name', models.CharField(max_length=30)),
                ('user_email', models.CharField(max_length=30)),
                ('user_type', models.CharField(max_length=30)),
                ('user_role', models.CharField(max_length=30)),
                ('user_password', models.CharField(max_length=30)),
                ('user_bio', models.TextField(default='user_bior')),
                ('user_dp', models.ImageField(blank=True, null=True, upload_to='users_profile_images')),
            ],
        ),
        migrations.AddField(
            model_name='post',
            name='posted_by_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='poll_participation',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='poll',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='notification_user',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='media',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='logout_log',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='login',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='likes',
            name='liked_user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='likes',
            name='post_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.post'),
        ),
        migrations.AddField(
            model_name='leave_club_log',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='event_registered_user',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='event',
            name='event_venue',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.room'),
        ),
        migrations.AddField(
            model_name='event',
            name='organizer_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='comment',
            name='post_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.post'),
        ),
        migrations.AddField(
            model_name='comment',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='club_registered_member',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
        migrations.AddField(
            model_name='club_admin',
            name='user_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
    ]
