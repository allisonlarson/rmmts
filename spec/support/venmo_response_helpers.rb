module VenmoResponseHelpers
  def successful_response(amount)
    OpenStruct.new(status: 200, body: JSON.generate({
      "data": {
        "balance": 9.90,
        "payment": {
          "id": "1322585332520059420",
          "status": "settled",
          "note": "Rock Climbing!",
          "amount": amount,
          "action": "pay",
          "date_created": "2013-12-30T19:40:57.865985",
          "date_completed": "2013-12-30T19:40:57.865985",
          "audience": "public",
          "target": {
            "type": "user",
            "phone": nil,
            "email": nil,
            "user": {
              "username": "testuser",
              "first_name": "Test",
              "last_name": "User",
              "display_name": "Test User",
              "about": "Long walks on the beach, sunsets, testing",
              "profile_picture_url": "https://venmopics.appspot.com/u/v3/s/6ecc7b37-5c4a-49df-b91e-3552f02dc397",
              "id": "145434160922624933",
              "date_joined": "2013-02-10T21:58:05"
            }
          },
          "actor": {
            "username": "delavara",
            "first_name": "Cody",
            "last_name": "De La Vara",
            "display_name": "Cody De La Vara",
            "about": "So happy",
            "profile_picture_url": "https://venmopics.appspot.com/u/v3/s/6ecc7b37-5c4a-49df-b91e-3552f02dc397",
            "id": "1088551785594880949",
            "date_joined": "2013-02-10T21:58:05"
          },
          "fee": nil,
          "refund": nil,
          "medium": "api",
        }
      }
    }))
  end

end
