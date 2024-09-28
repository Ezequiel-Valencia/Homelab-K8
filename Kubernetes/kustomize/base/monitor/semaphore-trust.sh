#!/bin/bash

ssh -o "StrictHostKeyChecking=accept-new" zeke@10.0.0.6 -p 5320
ssh -o "StrictHostKeyChecking=accept-new" zeke@10.0.0.7 -p 5320
ssh -o "StrictHostKeyChecking=accept-new" zeke@10.0.0.8 -p 5320
ssh -o "StrictHostKeyChecking=accept-new" zeke@10.0.0.11 -p 5320
ssh -o "StrictHostKeyChecking=accept-new" zeke@10.0.0.12 -p 5320
ssh -o "StrictHostKeyChecking=accept-new" zeke@10.0.0.15 -p 5320
ssh -o "StrictHostKeyChecking=accept-new" zeke@nextcloud.homelab.ezequielvalencia.com -p 8024
