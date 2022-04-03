import sys
import requests
url = 'https://pypi.org/pypi/{}/json'
json = requests.get(url.format(sys.argv[1])).json()
print(json['info']['requires_dist'])
