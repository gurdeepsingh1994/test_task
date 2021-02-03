# README

# ADD OR GET CANONICAL URL ID (POST gurdeep.singh.hiring.keywee.io/stories?url={some_url})
		 
    example 1:- 
		 curl --location --request POST 'http://gurdeep.singh.hiring.keywee.io/stories?url=https://ogp.me/' --header 'Content-Type: application/json'
		 response:- {"story_id":1}

    example 2:- 
     curl --location --request POST 'http://gurdeep.singh.hiring.keywee.io/stories?url=https://www.facebook.com/' --header 'Content-Type: application/json'
     response:- {"story_id":2}


# SCRAPE URL METADATA (GET gurdeep.singh.hiring.keywee.io/stories/{url-unique-id})
		 
     example 1:- 
		 curl --location --request GET 'http://gurdeep.singh.hiring.keywee.io/stories/1'
		 response:-
				{
						"story": {
								"id": 1,
								"canonical_url": "https://ogp.me/",
								"og_type": "website",
								"title": "Open Graph protocol",
								"scrape_status": "done",
								"updated_time": "2021-02-03 11:44:42 UTC",
								"images": [
								    {
								        "url": "https://ogp.me/logo.png",
								        "image_type": "image/png",
								        "width": "300",
								        "height": "300",
								        "alt": "The Open Graph logo"
								    }
								]
						}
				}

	example 2:-
	curl --location --request GET 'http://gurdeep.singh.hiring.keywee.io/stories/2'
	response:- 
	{
		  "story": {
		      "id": 2,
		      "canonical_url": "https://www.facebook.com/",
		      "og_type": null,
		      "title": null,
		      "scrape_status": "done",
		      "updated_time": "2021-02-03 11:45:49 UTC",
		      "images": [
		          {
		              "url": "https://www.facebook.com/images/fb_icon_325x325.png",
		              "image_type": null,
		              "width": null,
		              "height": null,
		              "alt": null
		          }
		      ]
		  }
	}
