# Generated by Django 2.1.2 on 2018-10-25 17:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('CREW', '0003_auto_20181025_2234'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='user_id',
            field=models.IntegerField(default=1, primary_key=True, serialize=False),
        ),
    ]
