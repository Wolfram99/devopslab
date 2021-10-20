#!/usr/bin/python3

import requests
import argparse

def main():

    parser=argparse.ArgumentParser()

    d = dict.fromkeys(['q','units','APPID'])

    parser.add_argument('City', type=str, help='City name')
    parser.add_argument('apikeyfile', help="the name of the file")
    parser.add_argument('--units', default='c', help="Temperature units")
    args = parser.parse_args()
    apikeyfile = args.apikeyfile
    with open(apikeyfile, 'r') as file:
        d['APPID'] = file.read()
    
    d['q'] = args.City   

    if args.units == "c":
        d['units'] = "metric"
    elif args.units == "k":
        d['units'] = "standard"
    elif args.units == "f":
        d['units'] = "imperial"
    else:
        print("the temperature measurement unit is specified incorrectly. the temperature measurement unit is set to Celsius")
        d['units'] = "metric"

    response = requests.get('http://api.openweathermap.org/data/2.5/weather', params=d)

    if response.status_code !=200:
        print("Error", response.status_code)
    else:
        json_output = response.json()
        City_Name = (json_output["name"])
        Weather = (json_output["weather"][0]["main"])
        Temp = (json_output["main"]["temp"])
        feels_like = (json_output["main"]["feels_like"])
        print("Current weather in " +City_Name+ ":" +Weather+ "\nTemperature is "+(str(Temp))+", but feels like "+(str(feels_like)))

if __name__ == "__main__":
    main()

