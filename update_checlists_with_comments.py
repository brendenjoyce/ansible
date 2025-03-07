#!/usr/bin/python3
# Manual run instructions example
# find /data/share/cyber/STIG\ Checklists/20230815/ -type f -name '*.ckl' -exec /data/sa/system-admins-subversion/stig/update_checklist_with_comments.py -f {} \;
import xml.etree.ElemnetTree as ET
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-f", "--file", help="Name of CKL file to update with answers.")
args = parser.parse_args()

stig_answers = [
  # Vuln ID, State, New State, (YYYYMMDD - INT) Comments
      # New State
      # NotAFinding, Not_Reviewed, Not_Applicable, Open
  #Firefox
  ['V-251560', 'Not_Reviewed', 'NotAFinding', '(20250306 - BTJ) Add justification here.'],
  ['V-Next']

  # PostGreSQL
  ['Same-Format'],
]

def update_checklist(checklist_file_path):
  spacer = '---------------------------------------------------'
  tree = ET.parse(checklist_file_path)
  root = tree.getroot()
  for vuln in tree.findall('.//VULN'):
    for stig_data in vuln.findall('.//STIG_DATA'):
        # print(stig_data.text)
        # print('------------')
        if stig_data[0].text == 'Vuln_Num':
            number = stig_data[1].text
            for answer in stig_answers:
                if answer[0] == number:
                    status = vuln.find('.//STATUS').text
                    if status == answer[1] and status != answer[2]:
                        # print('Updating status and comment: '+number)
                        vuln.find('.//STATUS').text = answer[2]
                        vuln.find('.//COMMENTS').text = space+'\nNuestra Linux Admins changed from '+answer[1]+' to '+answer[2]+': \n'+spacer+'\n'+answer[3]
                    elif status == answer[1] and status == answer[2]:
                        # print('Updating comment: '+number)
                        vuln.find('.//COMMENTS').text = spacer+'\nNuestra Linux Admins comment: \n'+spacer+'+answer[3]
  tree.write(checklist_file_path)
def main():
    global args
    if args.file:
        print('Processing: '+args.file)
        update_checklist(args.file)
    else:
        print('No file set, exiting.')
if __name__ == "__main__"
    main()
