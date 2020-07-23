# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey has `on_delete` set to the desired behavior.
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from datetime import datetime
from django.contrib.auth.models import AbstractUser
from django.contrib.auth.models import AbstractBaseUser


class Bookmark(models.Model):
    lat = models.FloatField(primary_key=True)
    lon = models.FloatField()
    passenger_mobile = models.ForeignKey('Users', models.DO_NOTHING, db_column='passenger_mobile')
    title = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'bookmark'
        unique_together = (('lat', 'lon', 'passenger_mobile'),)


class Car(models.Model):
    pelak = models.CharField(primary_key=True, max_length=20)
    color = models.CharField(max_length=20)
    year = models.DateField()

    class Meta:
        managed = False
        db_table = 'car'


class City(models.Model):
    name = models.CharField(max_length=30)

    class Meta:
        managed = False
        db_table = 'city'


class DefaultComment(models.Model):
    text = models.CharField(max_length=200)

    class Meta:
        managed = False
        db_table = 'default_comment'


class Gift(models.Model):
    type = models.AutoField(primary_key=True)
    value = models.IntegerField()
    name = models.CharField(max_length=10)

    class Meta:
        managed = False
        db_table = 'gift'
        unique_together = (('type', 'value'),)


class Gifted(models.Model):
    type = models.ForeignKey(Gift, models.DO_NOTHING, db_column='type', primary_key=True)
    value = models.IntegerField()
    mobile = models.ForeignKey('Users', models.DO_NOTHING, db_column='mobile')

    class Meta:
        managed = False
        db_table = 'gifted'
        unique_together = (('type', 'value', 'mobile'),)


class Own(models.Model):
    pelak = models.ForeignKey(Car, models.DO_NOTHING, db_column='pelak', primary_key=True)
    mobile = models.ForeignKey('Users', models.DO_NOTHING, db_column='mobile')

    class Meta:
        managed = False
        db_table = 'own'
        unique_together = (('pelak', 'mobile'),)


class PricePerCity(models.Model):
    id = models.ForeignKey(City, models.DO_NOTHING, db_column='id', primary_key=True)
    price_per_kilometer = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'price_per_city'


class Role(models.Model):
    name = models.CharField(max_length=30)

    class Meta:
        managed = False
        db_table = 'role'


class Takhfif(models.Model):
    time = models.DateTimeField()
    travel = models.ForeignKey('Travel', models.DO_NOTHING)
    price = models.IntegerField()
    code = models.CharField(max_length=10, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'takhfif'


class Travel(models.Model):
    travel_id = models.AutoField(primary_key=True)
    start_point = models.FloatField()
    start_point_lon = models.FloatField()
    starttime = models.DateTimeField()
    driver_mobile = models.ForeignKey('Users', models.DO_NOTHING, db_column='driver_mobile', related_name='driver_mobile')
    passenger_mobile = models.ForeignKey('Users', models.DO_NOTHING, db_column='passenger_mobile', related_name='passenger_mobile')
    destination_lat = models.FloatField()
    destination_lon = models.FloatField()
    type_of_payment = models.CharField(max_length=1)
    price = models.IntegerField()
    final_price = models.IntegerField()
    city = models.ForeignKey(City, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'travel'


class TravelPart(models.Model):
    travel = models.ForeignKey(Travel, models.DO_NOTHING, primary_key=True)
    no = models.IntegerField()
    lat = models.FloatField()
    lon = models.FloatField()
    rest_time = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'travel_part'
        unique_together = (('travel', 'no'),)


class TravelVote(models.Model):
    travel = models.ForeignKey(Travel, models.DO_NOTHING, primary_key=True)
    from_field = models.ForeignKey('Users', models.DO_NOTHING, db_column='from_id', related_name='from_id')  # Field renamed because it was a Python reserved word.
    star = models.IntegerField(blank=True, null=True)
    default_comment = models.ForeignKey(DefaultComment, models.DO_NOTHING)
    comment = models.TextField(blank=True, null=True)
    to = models.ForeignKey('Users', models.DO_NOTHING, db_column='to_id', related_name='to_id')

    class Meta:
        managed = False
        db_table = 'travel_vote'
        unique_together = (('travel', 'from_field'),)


class Users(AbstractUser):
    username = None
    mobile = models.CharField(primary_key=True, max_length=11)
    name = models.CharField(max_length=100)
    first_name = None
    last_name = None
    email = None
    is_staff = False
    date_joined = None
    # password = models.CharField(max_length=50)
    password = None
    lastname = models.CharField(max_length=100)
    profit = models.IntegerField()
    is_active = models.BooleanField()
    is_superuser = models.BooleanField()
    role = models.ForeignKey(Role, models.DO_NOTHING)
    city = models.ForeignKey(City, models.DO_NOTHING)
    last_login = models.DateTimeField(default=datetime.now, blank=True)
    
    USERNAME_FIELD = 'mobile'
    REQUIRED_FIELDS = []

    class Meta:
        managed = False
        db_table = 'users'

    def __str__(self):
        return self.mobile
