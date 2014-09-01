Domain:
==========

http://tickey.herokuapp.com/

Admin Panel
==========

http://tickey.herokuapp.com/:lang/admin
- params[:lang]

Users:

http://tickey.herokuapp.com/:lang/admin/user
- params[:lang]

Lines:

http://tickey.herokuapp.com/:lang/admin/line
- params[:lang]

Line Devies:

http://tickey.herokuapp.com/:lang/admin/line_device
- params[:lang]

Transport Card Types:

http://tickey.herokuapp.com/:lang/admin/transport_card_type
- params[:lang]

Vehicle Devices

http://tickey.herokuapp.com/:lang/admin/vehicle_device
- params[:lang]

Card Purchases

http://tickey.herokuapp.com/:lang/admin/card_purch
- params[:lang]


JSON Examples Get:
==========

http://tickey.herokuapp.com/:lang/cms/transport_card_types.json
- parmas[:lang]

http://tickey.herokuapp.com/:lang/api/vehicle_devices/line_name_by_uuid/:uuid.json
- params[:lang]
- params[:uuid]

http://tickey.herokuapp.com/:lang/api/card_purches/user_active_cards/:user_id/:uuid.json
- params[:lang]
- params[:user_id]
- params[:uuid]

http://tickey.herokuapp.com/:lang/api/vehicle_devices/get_vehicle_users/:uuid.json
- params[:user_id]
- params[:lang]

JSON Examples Post:
==========

http://tickey.herokuapp.com/:lang/api/users/authenticate.json
- params[:lang]
- params[:email]
- params[:password]. Password must be sha1

http://tickey.herokuapp.com/:lang/api/users/register_user.json
- params[:lang]
- params[:email]
- params[:password]. Password must be sha1
- params[:first_name]
- params[:last_name]
- params[:pin]

http://tickey.herokuapp.com/:lang/api/card_purches/make_order.json
- params[:lang]
- params[:user_id]
- params[:line_name]
- params[:card_type]

