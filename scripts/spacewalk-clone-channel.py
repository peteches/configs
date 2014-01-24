#! /usr/bin/python3

import sys
import xmlrpc.client

SATELLITE_URL = 'https://10.250.140.18/rpc/api'
SATELLITE_LOGIN = 'admin'
SATELLITE_PASSWORD = 'Sh33pd0g'

client = xmlrpc.client.Server(SATELLITE_URL, verbose=0)
key = client.auth.login(SATELLITE_LOGIN, SATELLITE_PASSWORD)

channel_to_clone = sys.argv[1]
name_of_tag = sys.argv[2]

parent_details = client.channel.software.get_details(key,
                                                     channel_to_clone)

if parent_details['parent_channel_label']:
    sys.exit('Error: {} is not Base channel.'.format(channel_to_clone))

children_to_clone = client.channel.software.listChildren(key, channel_to_clone)

new_channel = {
    'name':  'cloned-env-for-{}'.format(name_of_tag),
    'label': 'cloned-env-for-{}'.format(name_of_tag),
    'summary': 'Clone channel for testing tag: {}'.format(name_of_tag)
}

try:
    client.channel.software.clone(key, channel_to_clone, new_channel)
except:
    sys.exit('Error cloning base channel {}'.format(channel_to_clone))

for channel in children_to_clone:
    new_channel = {
        'arch_label': channel['arch_label'],
        'description': channel['description'],
        'gpg_key_fp': channel['gpg_key_fp'],
        'gpg_key_id': channel['gpg_key_id'],
        'gpg_key_url': channel['gpg_key_url'],
        'label': channel['label'],
        'name': channel['name'],
        'parent_label': 'cloned-env-for-{}'.format(name_of_tag),
        'summary': channel['summary'],
    }

    client.channel.software.clone(key, channel, new_channel)
