########### VARIABLES ##############
GCP_PROJECT="sopes1-proyecto1"
SERVICE_NAME="reversed-proxy"
REGION="us-central1"

###### GENERATED VARIABLES #########
VERSION="1.0.0"
IMAGE_NAME="gcr.io/$GCP_PROJECT/$SERVICE_NAME"
IMAGE_NAME_VERSION="$IMAGE_NAME:$VERSION"
IMAGE_NAME_LATEST="$IMAGE_NAME:latest"

############# BUILD ################
echo "Create Docker image via 'Cloud Build' ..."
gcloud builds submit  \
  --tag "$IMAGE_NAME_VERSION" \
  --project $GCP_PROJECT

########### DEPLOYMENT #############
echo "Deploying Cloud Run Service '$SERVICE_NAME' to '$GCP_PROJECT' in '$REGION'"
gcloud run deploy $SERVICE_NAME \
  --image "$IMAGE_NAME_VERSION" \
  --project $GCP_PROJECT \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated
