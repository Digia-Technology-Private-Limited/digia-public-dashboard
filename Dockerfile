FROM public.ecr.aws/k2y9b2n4/digia-dashboard:1.2.2 AS flutter-build

ARG env

WORKDIR /app

RUN flutter doctor

COPY configs configs

RUN flutter build web --release --no-tree-shake-icons --dart-define-from-file=configs/$env-config.json


#Run stage
FROM node:16-alpine as dev
WORKDIR /app

COPY --from=flutter-build /app/package*.json  .

RUN npm install --omit=dev

COPY --from=flutter-build /app/server.js  .

COPY --from=flutter-build /app/build ./build


# Expose the application port
EXPOSE 4000

# Start the Node.js application
CMD ["npm", "start"]


