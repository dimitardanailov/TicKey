Domain:
==========

http://tickey.herokuapp.com/

Admin Panel
==========

http://tickey.herokuapp.com/admin

CMS:
==========

Users:

http://tickey.herokuapp.com/:lang/cms/users
- params[:lang]

Lines:

http://tickey.herokuapp.com/:lang/cms/lines
- params[:lang]

Line Devies:

http://tickey.herokuapp.com/:lang/cms/line_devices
- params[:lang]

Transport Card Types:

http://tickey.herokuapp.com/:lang/cms/transport_card_types
- params[:lang]

Vehicle Devices

http://tickey.herokuapp.com/:lang/cms/vehicle_devices
- params[:lang]

Card Purchases

http://tickey.herokuapp.com/:lang/cms/card_purches
- params[:lang]


JSON Examples Get:
==========

http://tickey.herokuapp.com/transport_card_types.json

http://tickey.herokuapp.com/:lang/vehicle_devices/line_name_by_uuid/:uuid.json
- params[:lang]
- params[:uuid]

http://tickey.herokuapp.com/:lang/card_purches/user_active_cards/:user_id/:uuid.json
- params[:lang]
- params[:user_id]
- params[:uuid]

http://tickey.herokuapp.com/:lang/vehicle_devices/get_vehicle_users/:uuid.json
- params[:user_id]
- params[:lang]

JSON Examples Post:
==========

http://tickey.herokuapp.com/:lang/users/authenticate.json
- params[:lang]
- params[:email]
- params[:password]. Password must be sha1

http://tickey.herokuapp.com/:lang/users/register_user.json
- params[:lang]
- params[:email]
- params[:password]. Password must be sha1
- params[:first_name]
- params[:last_name]
- params[:pin]

http://tickey.herokuapp.com/:lang/card_purches/make_order.json
- params[:lang]
- params[:user_id]
- params[:line_name]
- params[:card_type]

