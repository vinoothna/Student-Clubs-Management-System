# Generated by Django 2.1.2 on 2018-12-10 11:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('CREW', '0002_club_club_active_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='event',
            name='event_description',
            field=models.TextField(default='Event description'),
            preserve_default=False,
        ),
    ]
