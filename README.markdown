# Yardoc RESTful Web Service Plugin
A plugin for [Yardoc](http://yardoc.org/) that generates documentation for RESTful web services.

Previous authors: [vWorkApp](http://www.vworkapp.com), [rknLA](http://github.com/rknLA), [lsegal](http://gnuu.org/), [spape](http://github.com/spape), [DerNalia](http://github.com/DerNalia)

## Main features
Plugin provides custom tags to describe resources (controllers) and resulting objects (models).


If you use an object name in description of resource parameters, it will
be linked to the object description.

## Install
Bundler will reduce your headaches:

	gem 'yard-restful' # in your gemfile

You may need to include the following dependencies as well:

	gem 'redcarpet'
	gem 'yard'

It also requires the Jeweler gem if you plan to use the rake build tasks.

You'll probably want to add these to your .gitignore as well

	.yardoc
	public/api

So you'll have to re-genenarte your API on every machine. This should encourage more up to dateness

## Execution
It is recommended that you use a .yardopts file

	--title "My API Documentation"
	--plugin restful
	--readme API_README
	--output-dir ./public/api
	app/models/**/*.rb
	app/controllers/**/*.rb

So that way, whenever you want to generate your API docs, you simply need to run only

	bundle exec yardoc


## Samples

[Full rails 3 application](http://github.com/kraft001/yard-restful-sample) with [documentation](http://kraft001.github.com/yard-restful-sample/index.html)

[Example documentation](http://kraft001.github.com/yard-restful/index.html), also [with frames](http://kraft001.github.com/yard-restful/frames.html)

[Sample controller](http://github.com/kraft001/yard-restful/blob/master/example/books_controller.rb) and [sample model](http://github.com/kraft001/yard-restful/blob/master/example/book.rb)

## Writing Comments

The following tags are provided:

- **@restful_api** version

  Specifies the resource (controller) or object (model). This tag is compulsory, only **classes** that include this in their comments are included in the API documentation.

- **@url** url

  Specifies the URL which someone should use to access that resource. This tag is compulsory, only **methods** that include this in their comments are included in the API documentation

- **@action** action

  Specifies the http action (GET, POST, PUT etc.).  Defaults to GET

- **@required** [type] name description

  Specifies an argument that must be passed to the service. You can specify as many of these as you need.

- **@optional** [type] name description

  Specifies an optional argument that may be passed to the service. You can specify as many of these as you need.

- **@response** [type] description

  Specifies type of the response. Usually just a link to an object.

- **@response_field** [type] name description

  Further specifies the fields that are returned within the response.

- **@property** [type] name description

  A property (attribute) of an object.

### Examples

Examples should always be together in the following order: example_request, example_request_description, example_response, example_response_description (as soon as you write an example_request you need a following example_response and the other way around).

Markdown rendering for the text is activated if a tags text contains a newline (see example).

- **@example_request**

  An example of the request that is send to the service.

- **@example_request_description**

  The description text for the example request.

- **@example_response**

  An example of the response that is returned from the service.

- **@example_response_description**

  The description text for the example response.

- **@example**

  Example of an object.

## Ignored Documentation

This plugin only documents **classes** and **methods** with **@restful_api** tag. It does not support module documentation.

## Development

As always, you can see what tasks are available by running:

    rake -T

You can run the template locally over the included sample code by using the following rake tasks:

    rake example:generate
    rake example:clean

