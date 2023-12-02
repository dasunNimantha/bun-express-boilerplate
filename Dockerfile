FROM oven/bun:1.0.14-alpine AS base
WORKDIR /usr/src/app

FROM base AS install
COPY package.json bun.lockb /usr/src/app/
RUN bun install --frozen-lockfile --production
COPY . .
RUN bun build app.ts --target bun --minify --outdir dist


FROM base AS release
COPY --from=install /usr/src/app/dist .


ENTRYPOINT [ "bun", "run", "app.js" ]

