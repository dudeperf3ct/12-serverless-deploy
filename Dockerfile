FROM public.ecr.aws/lambda/python:3.8

COPY requirements.txt ./
RUN python3 -m ensurepip
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir model
RUN curl -L https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english/resolve/main/pytorch_model.bin -o ./model/pytorch_model.bin
RUN curl https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english/resolve/main/config.json -o ./model/config.json
RUN curl https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english/resolve/main/tokenizer.json -o ./model/tokenizer.json
RUN curl https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english/resolve/main/tokenizer_config.json -o ./model/tokenizer_config.json
RUN curl https://huggingface.co/distilbert-base-uncased-finetuned-sst-2-english/resolve/main/vocab.txt -o ./model/vocab.txt

COPY setup.py ./setup.py
RUN pip install .

COPY . ./

CMD ["project.app.handler"]