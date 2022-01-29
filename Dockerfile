FROM public.ecr.aws/lambda/python:3.8

COPY requirements.txt ${LAMBDA_TASK_ROOT}

RUN python3 -m ensurepip
RUN pip install --no-cache-dir -r requirements.txt

COPY setup.py ${LAMBDA_TASK_ROOT}/setup.py

RUN pip install .

COPY . ${LAMBDA_TASK_ROOT}

CMD ["project.app.handler"]