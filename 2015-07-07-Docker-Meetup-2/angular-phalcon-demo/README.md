# Angular/Phalcon/PSQL Demo

This is a quick demo I wrapped up for the second meeting Docker Meetup in Sofia, demonstrating a quick devenv with docker compose.
It contains a number of inefficiencies, while it is a good starting template, I wouldn't recommend using as is
in any sort of real development environment. Keep in mind that the repo is intentionally mising a .gitignore file,
and there is a fair bit of ignores to do when building assets using compose like this!

## To Use

* clone the repository
* point demo.dev & demo-api.dev to the IP where your containers will reside(usually the machine where docker-compose will be ran)
* docker-compose up


## Support

I'm not supporting this, sorry, I'll try and release a proper version of the images if I get the time, but thats about it.
