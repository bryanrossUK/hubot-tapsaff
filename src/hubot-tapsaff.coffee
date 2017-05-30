# Description:
#   Find out if its tapsaff weather in your location.
#
# Commands:
#   tapsaff           - get the tapsaff status for the default location (HUBOT_TAPSAFF_TOON)
#   tapsaff in <toon> - get the tapsaff status for the specified location
#
# Configuration:
#   HUBOT_TAPSAFF_TOON - optional default location for lookups

module.exports = (robot) ->
  robot.respond /tapsaff in (.+)$/i, (msg) ->
    toon = msg.match[1]
    robot.http("http://www.taps-aff.co.uk/?api&location=#{toon}")
      .get() (err, res, body) ->
        if err
          msg.send "Hit a problem - #{err}"
          return

        json = JSON.parse body
        if json.place_error
          msg.send "Soz big yin, I dinnae ken whur #{toon} is."
          return

        msg.send "yer tap should be #{json.taps} in #{json.location}. The weather's #{json.description} there the now."
        return

  robot.respond /tapsaff$/i, (msg) ->
    toon = process.env.HUBOT_TAPSAFF_TOON
    unless toon?
      msg.send "You havnae told me whur aboots.  (try setting HUBOT_TAPSAFF_TOON or 'tapsaff in <place>')"
      return

    robot.http("http://www.taps-aff.co.uk/?api&location=#{toon}")
      .get() (err, res, body) ->
        if err
          msg.send "Hit a problem - #{err}"
          return

        json = JSON.parse body
        if json.place_error
          msg.send "Soz big yin, I dinnae ken whur #{toon} is."
          return

        msg.send "yer tap should be #{json.taps} in #{json.location}. The weather's #{json.description}."
        return
