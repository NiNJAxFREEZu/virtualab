import sys
import json

class_config_json_raw = open(sys.argv[1])
class_config_json= json.loads(class_config_json_raw)

print(class_config_json)
