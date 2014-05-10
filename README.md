Domain: 
==========

http://tickey.herokuapp.com/

CMS:
==========

Users:

http://tickey.herokuapp.com/users

Lines:

http://tickey.herokuapp.com/lines

Line Devies:

http://tickey.herokuapp.com/line_devices

Transport Card Types:

http://tickey.herokuapp.com/transport_card_types

Vehicle Devices

http://tickey.herokuapp.com/vehicle_devices


JSON Examples Get: 
==========

http://tickey.herokuapp.com/transport_card_types.json

http://tickey.herokuapp.com/vehicle_devices/line_name_by_uuid/2324234234234234.json
- params[:uuid]


JSON Examples Post: 
==========

http://tickey.herokuapp.com/users/authenticate.json
- params[:email]
- params[:password]. Password must be sha1

http://tickey.herokuapp.com/users/register_user.json
- params[:email]
- params[:password]. Password must be sha1
- params[:first_name]
- params[:last_name]
- params[:pin]

