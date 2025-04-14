# WEEK 1
What is AI?
Artificial Intelligence (AI) is the ability of a computer or machine to perform tasks that typically require human intelligence, such as learning, problem-solving, and decision-making. AI in DevOps involves using machine learning and other AI technologies to automate and optimize software development and delivery processes, enhancing speed, accuracy, and reliability throughout the software lifecycle. 

## Different types of AI
Traditional AI is an AI that holds historical data and uses to predict future outcomes. For example weather prediction. It predicts the temperature based on weather reports from the past.

Generative AI primary case use is to generate new content like text, images, videos. The input can be something you imagined and it generates a completely new content whether they be text, images and videos and llms

Large language models is focused on text generation and it is part of Generative AI e.g of llm are deepseek, chatgp, llama. They are trained using super computers 


Traditional AI in DevOps helps in observability and instance management, logistics management, auto scaling and report any incidence that can occur future


Generative AI in DevOps can be used to create a new kubrrnetes Manifest 


### AI Landscape for DevOps 
1. AI Landscape chatbot
2. AI agents
3. AI assistance 
4. Scripting/programming language 


## Task 1

Create a shell script where the script should analyse the health of the virtual machine based on cpu, memory and disk space. if any of these three things are less than 60% utilized. The script declares the state of VM as healthy whereas if any of these parameters are more than 60%, script declares the health as non-healthy.

Also the script should support a command line argument named "explain" when passed the script should explain the reason for health status along with printing the health status.


# WEEK 2 - PROMPT ENGINEERING

Prompt engineering in lay man terms means that a user inputs words(prompt) in an AI model(LLM) and then generates an output. The process of enhancing the users prompt to enable AI model(LLM) output a content that is expected is prompt engineering. A good prompt can significantly reduce cost for an organization.

## Techniques of Prompt Engineering
- zero-shot prompting
- one-shot prompting
- few-shot prompting
- system prompting
- contextual prompting
- role prompting
- step-back promptig
- chain of thought

1. Zero shot prompting means you provide a prompt without an example. It is the simplest type of prompt. The prompt could be a start of a story, a question or a set of instructions. This is useful when you are going with popular or familiar use cases.

2. One Shot prompting means you provide a prompt with a single example. This technique shows the model an example it can imitate to complete the task while  while few shot prompting means you provide a prompt with multiple examples. This technique shows the model the pattern that it needs to follow. It isnuseful because in your organization they may have a coding style of writing scripts. when you give LLMs eaxmples of the style of coding in your organization. LLM can now geerate contents with the style you have given it.

3. System prompting describes the overall context and purpose for the model. It defines the big picture of what the model should be doing, like translating a language, classifying a review etc

4. Contextual prompting provides specific details and background information relevant to the current conversation or task. It helps the models understand the nuances being asked and tailor the responses accordingly


5. Multishot is similar to few shot prompting. In this case you provide more examples and more context

6. Chain of thought is a prompting style that enhances the performance of LLM's. It can perform better because it enables the LLM's to use its reasoning capabilities.

**NOte:** Let the input be as elaborate as possible and let the ouput be concise, clear and straight to the point

## Stategy Of prompt engineering
1. Provide context
2. Provide examples
3. provide instructions
4. Define the format of the output you want (csv, yml, md etc)


## Task 2
Live Demo: Demonstrate an example of few shot prompting in real time.
