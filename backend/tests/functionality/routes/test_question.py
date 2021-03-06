# coding: utf-8

import pytest
from conftest import header
from factories import QuestionFactory
from flask import url_for


@pytest.mark.usefixtures("db")
class TestQuestion:

    def test_get_questions(self, client, user, question):
        resp = client.get(url_for("question.get_questions"), headers=header(user.token))
        assert isinstance(resp.json, list)

    def test_get_question(self, client, user, question):
        resp = client.get(
            url_for("question.get_question", question_id=question.id),
            headers=header(user.token),
        )
        assert resp.json["question"] == question.__dict__["question"]
