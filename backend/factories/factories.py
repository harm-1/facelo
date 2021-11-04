# -*- coding: utf-8 -*-
"""Factories to help in tests."""
import datetime
from random import choice

import factory
from factory import Faker, LazyAttribute, PostGeneration, SubFactory
from factory.alchemy import SQLAlchemyModelFactory
from flask_jwt_extended import create_access_token

from facelo.challenge.models import Challenge
from facelo.database import db
from facelo.image.models import Image
from facelo.question.models import Question
from facelo.trial.models import Trial
from facelo.user.models import User


class BaseFactory(SQLAlchemyModelFactory):
    """Base factory."""

    class Meta:
        """Factory configuration."""

        abstract = True
        sqlalchemy_session = db.session


class UserFactory(BaseFactory):
    """User factory."""

    email = Faker("email")
    password = Faker("password")
    birth_day = Faker(
        "date_between_dates",
        date_start=datetime.date(1900, 1, 1),
        date_end=datetime.date(2020, 1, 1),
    )
    gender = Faker("random_int", min=0, max=2)
    sexual_preference = Faker("random_int", min=0, max=7)
    karma = Faker("random_int", min=0, max=300)

    # token = PostGeneration(lambda obj, create, extracted, **kwargs: obj.create_access_token()
    #                        if hasattr(obj, 'create_access_token') else None)
    # token = PostGenerationMethodCall('create_access_token')

    class Meta:
        """Factory configuration."""

        model = User


def lazy_users():
    """Turn `User.query.all()` into a lazily evaluated generator"""
    while True:
        user_list = User.query.all()
        yield choice(user_list) if user_list else None


class ImageFactory(BaseFactory):
    """Image factory."""

    image_url = Faker("image_url")
    date_taken = Faker("past_datetime")
    user = factory.Iterator(lazy_users())

    class Meta:
        """Factory configuration."""

        model = Image


def lazy_images():
    while True:
        yield choice(Image.query.all())
        # for image in Image.query.all():
        #     yield image


class QuestionFactory(BaseFactory):
    """Question factory."""

    question = Faker("sentence", nb_words=10)

    class Meta:
        """Factory configuration."""

        model = Question


def lazy_questions():
    while True:
        yield choice(Question.query.all())


class TrialFactory(BaseFactory):
    """Trial factory."""

    score = Faker("pyfloat", min_value=0, max_value=1)
    judge_age_min = Faker("random_int", min=1, max=50)
    judge_age_max = Faker("random_int", min=51, max=100)
    image = factory.Iterator(lazy_images())
    question = factory.Iterator(lazy_questions())

    class Meta:
        """Factory configuration."""

        model = Trial


def lazy_trials():
    curr = None
    while True:
        prev = curr
        while prev == curr:
            curr = choice(Trial.query.all())
        yield curr


class ChallengeFactory(BaseFactory):
    """Challenge factory."""

    judge_age = Faker("random_int", min=18, max=70)
    date = Faker("past_datetime")
    type = Faker("random_int", min=0, max=5)
    winner_has_revealed = Faker("boolean")
    loser_has_revealed = Faker("boolean")
    completed = Faker("boolean")
    judge = factory.Iterator(lazy_users())
    question = factory.Iterator(lazy_questions())
    winner = factory.Iterator(lazy_trials())
    loser = factory.Iterator(lazy_trials())

    class Meta:
        """Factory configuration."""

        model = Challenge
