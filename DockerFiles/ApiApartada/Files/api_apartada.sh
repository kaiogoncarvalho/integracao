export API_APARTADA_DIR=$(grep -E "APIAPARTADA_LOCAL=(.*)" ../../../.env | sed -n 's/^APIAPARTADA_LOCAL=*//p' ../../../.env)
cd $API_APARTADA_DIR
chmod 777 -R portal
cd portal/pravaler_v2/api/app
mkdir log