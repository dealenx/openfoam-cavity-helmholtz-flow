export $(cat .env)

# Paths
CASE_PATH="./prepared_case"

export $(cat ../.env)


# Variables
cp -r $CASE_PATH current_case
cd current_case


# Preparing salome mesh
echo '{"field_length": 15}' > case_vars.json
$SALOME_PATH/salome -t python ./generate_mesh.py 
ideasUnvToFoam ./mesh.unv
sed -i 's/patch/wall/' constant/polyMesh/boundary


# OpenFoam calcing with icoFoam solver 
icoFoam