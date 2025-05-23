import openai
prompt = '''# "Hello World!" 표시
        def helloworld():
        '''

response = openai.Completion.create(
    model="gpt-3.5-turbo-instruct",
    prompt=prompt,
    temperature=0.7,
    max_tokens=100
)

print(response.choices[0].text)
print(response)