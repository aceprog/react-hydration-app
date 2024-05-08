# Install dependencies
COPY package.json yarn.lock* package-lock.json* pnpm-lock.yaml* ./
RUN \
  if [ -f package-lock.json ]; then npm ci; \
  else echo "Lockfile not found." && exit 1; \
  fi


RUN npm run build

# Production image, copy all the files and run next
FROM base AS runner
WORKDIR /app

CMD ["node", "server.js"]