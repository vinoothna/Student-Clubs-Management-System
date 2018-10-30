# Generated by Django 2.1.2 on 2018-10-25 18:08

import datetime
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('CREW', '0009_auto_20181025_2337'),
    ]

    operations = [
        migrations.CreateModel(
            name='club',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('club_name', models.CharField(max_length=30)),
                ('club_advisor', models.CharField(max_length=30)),
                ('club_startdate', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('club_dp', models.ImageField(blank=True, null=True, upload_to='')),
                ('club_tc', models.FileField(upload_to='')),
            ],
        ),
        migrations.CreateModel(
            name='club_admin',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_of_joining', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='club_registered_member',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_of_joining', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='comment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField()),
                ('comment_datetime', models.DateTimeField(blank=True, default=datetime.datetime.now)),
            ],
        ),
        migrations.CreateModel(
            name='event',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('event_name', models.CharField(max_length=30)),
                ('event_start_datetime', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('event_end_datetime', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('event_type', models.CharField(max_length=30)),
                ('event_duration', models.IntegerField(default=0)),
                ('event_host', models.CharField(max_length=30)),
                ('event_limit', models.IntegerField(default=0)),
                ('event_file', models.FileField(upload_to='')),
            ],
        ),
        migrations.CreateModel(
            name='event_media',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('event_media_id', models.IntegerField(default=1)),
                ('media_type', models.CharField(max_length=30)),
                ('event_media', models.FileField(upload_to='')),
                ('event_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.event')),
            ],
        ),
        migrations.CreateModel(
            name='event_registered_user',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('register_datetime', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('event_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.event')),
            ],
        ),
        migrations.CreateModel(
            name='leave_club_log',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('leave_club_id', models.IntegerField(default=1)),
                ('date_of_leaving', models.DateTimeField(blank=True, default=datetime.datetime.now)),
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
                ('datetime_of_login', models.DateTimeField(blank=True, default=datetime.datetime.now)),
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
                ('notification_datetime', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='poll',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('poll_title', models.CharField(max_length=50)),
                ('poll_content', models.TextField()),
                ('poll_winner', models.IntegerField(default=1)),
                ('start_datetime', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('end_datetime', models.DateTimeField(blank=True, default=datetime.datetime.now)),
            ],
        ),
        migrations.CreateModel(
            name='poll_options',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('option', models.CharField(max_length=30)),
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
                ('content', models.TextField()),
                ('post_datetime', models.DateTimeField(blank=True, default=datetime.datetime.now)),
                ('club_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.club')),
            ],
        ),
        migrations.CreateModel(
            name='rooms',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('timestamp', models.DateTimeField(blank=True, default=datetime.datetime.now)),
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
                ('user_dp', models.ImageField(blank=True, null=True, upload_to='')),
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
            model_name='media',
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
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.rooms'),
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
        migrations.AddField(
            model_name='club',
            name='club_added_by',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='CREW.user'),
        ),
    ]
