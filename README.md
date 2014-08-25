Domain:
==========

http://tickey.herokuapp.com/

Admin Panel
==========

http://tickey.herokuapp.com/admin

CMS:
==========

Users:

http://tickey.herokuapp.com/cms/users

Lines:

http://tickey.herokuapp.com/cms/lines

Line Devies:

http://tickey.herokuapp.com/cms/line_devices

Transport Card Types:

http://tickey.herokuapp.com/cms/transport_card_types

Vehicle Devices

http://tickey.herokuapp.com/cms/vehicle_devices


JSON Examples Get:
==========

http://tickey.herokuapp.com/transport_card_types.json

http://tickey.herokuapp.com/vehicle_devices/line_name_by_uuid/:uuid.json
- params[:uuid]

http://tickey.herokuapp.com/card_purches/user_active_cards/:user_id/:uuid.json
- params[:user_id]
- params[:uuid]

http://tickey.herokuapp.com/vehicle_devices/get_vehicle_users/:uuid.json
- params[:user_id]

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

http://tickey.herokuapp.com/card_purches/make_order.json

- params[:user_id]
- params[:line_name]
- params[:card_type]

