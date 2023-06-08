import requests
data={"rollnumber":"22Z201","password":"1234","accesscode":""}
response=requests.post("https://psg-scapes-backend.onrender.com/api/auth/verify",json=data)
print(response.status_code)