# Generated by Django 2.2.2 on 2019-06-06 16:20

import datetime
import django.contrib.auth.models
import django.contrib.auth.validators
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Users',
            fields=[
                ('username', models.CharField(error_messages={'unique': 'A user with that username already exists.'}, help_text='Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.', max_length=150, unique=True, validators=[django.contrib.auth.validators.UnicodeUsernameValidator()], verbose_name='username')),
                ('first_name', models.CharField(blank=True, max_length=30, verbose_name='first name')),
                ('last_name', models.CharField(blank=True, max_length=150, verbose_name='last name')),
                ('email', models.EmailField(blank=True, max_length=254, verbose_name='email address')),
                ('is_staff', models.BooleanField(default=False, help_text='Designates whether the user can log into this admin site.', verbose_name='staff status')),
                ('date_joined', models.DateTimeField(default=django.utils.timezone.now, verbose_name='date joined')),
                ('mobile', models.CharField(max_length=11, primary_key=True, serialize=False)),
                ('password', models.CharField(max_length=50)),
                ('name', models.CharField(max_length=100)),
                ('lastname', models.CharField(max_length=100)),
                ('profit', models.IntegerField()),
                ('is_active', models.BooleanField()),
                ('is_superuser', models.BooleanField()),
                ('last_login', models.DateTimeField(blank=True, default=datetime.datetime.now)),
            ],
            options={
                'db_table': 'users',
                'managed': False,
            },
            managers=[
                ('objects', django.contrib.auth.models.UserManager()),
            ],
        ),
        migrations.CreateModel(
            name='Bookmark',
            fields=[
                ('lat', models.FloatField(primary_key=True, serialize=False)),
                ('lon', models.FloatField()),
                ('title', models.CharField(max_length=50)),
            ],
            options={
                'db_table': 'bookmark',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Car',
            fields=[
                ('pelak', models.CharField(max_length=20, primary_key=True, serialize=False)),
                ('color', models.CharField(max_length=20)),
                ('year', models.DateField()),
            ],
            options={
                'db_table': 'car',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='City',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=30)),
            ],
            options={
                'db_table': 'city',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='DefaultComment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('text', models.CharField(max_length=200)),
            ],
            options={
                'db_table': 'default_comment',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Gift',
            fields=[
                ('type', models.AutoField(primary_key=True, serialize=False)),
                ('value', models.IntegerField()),
                ('name', models.CharField(max_length=10)),
            ],
            options={
                'db_table': 'gift',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Role',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=30)),
            ],
            options={
                'db_table': 'role',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Takhfif',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('time', models.DateTimeField()),
                ('price', models.IntegerField()),
                ('code', models.CharField(blank=True, max_length=10, null=True)),
            ],
            options={
                'db_table': 'takhfif',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Travel',
            fields=[
                ('travel_id', models.AutoField(primary_key=True, serialize=False)),
                ('start_point', models.FloatField()),
                ('start_point_lon', models.FloatField()),
                ('starttime', models.DateTimeField()),
                ('destination_lat', models.FloatField()),
                ('destination_lon', models.FloatField()),
                ('type_of_payment', models.CharField(max_length=1)),
                ('price', models.IntegerField()),
                ('final_price', models.IntegerField()),
            ],
            options={
                'db_table': 'travel',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Gifted',
            fields=[
                ('type', models.ForeignKey(db_column='type', on_delete=django.db.models.deletion.DO_NOTHING, primary_key=True, serialize=False, to='default.Gift')),
                ('value', models.IntegerField()),
            ],
            options={
                'db_table': 'gifted',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Own',
            fields=[
                ('pelak', models.ForeignKey(db_column='pelak', on_delete=django.db.models.deletion.DO_NOTHING, primary_key=True, serialize=False, to='default.Car')),
            ],
            options={
                'db_table': 'own',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='PricePerCity',
            fields=[
                ('id', models.ForeignKey(db_column='id', on_delete=django.db.models.deletion.DO_NOTHING, primary_key=True, serialize=False, to='default.City')),
                ('price_per_kilometer', models.IntegerField()),
            ],
            options={
                'db_table': 'price_per_city',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='TravelPart',
            fields=[
                ('travel', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, primary_key=True, serialize=False, to='default.Travel')),
                ('no', models.IntegerField()),
                ('lat', models.FloatField()),
                ('lon', models.FloatField()),
                ('rest_time', models.IntegerField()),
            ],
            options={
                'db_table': 'travel_part',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='TravelVote',
            fields=[
                ('travel', models.ForeignKey(on_delete=django.db.models.deletion.DO_NOTHING, primary_key=True, serialize=False, to='default.Travel')),
                ('star', models.IntegerField(blank=True, null=True)),
                ('comment', models.TextField(blank=True, null=True)),
            ],
            options={
                'db_table': 'travel_vote',
                'managed': False,
            },
        ),
    ]
