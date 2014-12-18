sean_eshbaugh = User.where(username: 'seshbaugh').first
sean_eshbaugh.add_role :sysadmin

steve_goff = User.where(username: 'sgoff').first
steve_goff.add_role :owner
steve_goff.add_role :agent
