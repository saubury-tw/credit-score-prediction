FROM python:3.9.14-slim

WORKDIR /code

RUN apt-get update
RUN apt-get -y install gcc python3-dev python3-pip g++

RUN pip install poetry
RUN poetry config virtualenvs.create false
COPY pyproject.toml /code/pyproject.toml
RUN poetry install

# Configure PYTHONPATH so that packages/modules in src are symmetrically available to tests
# (doesn't include other clients - e.g. IDE, which require this to be set in their own config - e.g. .vscode/settings.json or .idea/xxx.iml)
ENV PYTHONPATH=/code/src

CMD ["bash"]