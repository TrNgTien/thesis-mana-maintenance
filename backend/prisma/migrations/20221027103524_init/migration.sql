-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "refreshToken" UUID,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "roleId" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "roles" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "roles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "namespaces" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "namespaces_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "theses" (
    "id" TEXT NOT NULL,
    "studentName" TEXT NOT NULL,
    "studentID" TEXT NOT NULL,
    "supervisorName" TEXT NOT NULL,
    "semester" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "summary" TEXT,
    "report" BYTEA,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "namespaceId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "theses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "thesis_tags" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "thesis_tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tag_on_thesis" (
    "thesisId" TEXT NOT NULL,
    "tagId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "tag_on_thesis_pkey" PRIMARY KEY ("thesisId","tagId")
);

-- CreateTable
CREATE TABLE "kube_files" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),
    "content" JSONB NOT NULL,
    "namespaceId" TEXT NOT NULL,

    CONSTRAINT "kube_files_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_refreshToken_key" ON "users"("refreshToken");

-- CreateIndex
CREATE UNIQUE INDEX "roles_name_key" ON "roles"("name");

-- CreateIndex
CREATE UNIQUE INDEX "namespaces_name_key" ON "namespaces"("name");

-- CreateIndex
CREATE UNIQUE INDEX "theses_studentID_key" ON "theses"("studentID");

-- CreateIndex
CREATE UNIQUE INDEX "theses_namespaceId_key" ON "theses"("namespaceId");

-- CreateIndex
CREATE UNIQUE INDEX "theses_userId_key" ON "theses"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "thesis_tags_name_key" ON "thesis_tags"("name");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "roles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "theses" ADD CONSTRAINT "theses_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "theses" ADD CONSTRAINT "theses_namespaceId_fkey" FOREIGN KEY ("namespaceId") REFERENCES "namespaces"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tag_on_thesis" ADD CONSTRAINT "tag_on_thesis_thesisId_fkey" FOREIGN KEY ("thesisId") REFERENCES "theses"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tag_on_thesis" ADD CONSTRAINT "tag_on_thesis_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "thesis_tags"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kube_files" ADD CONSTRAINT "kube_files_namespaceId_fkey" FOREIGN KEY ("namespaceId") REFERENCES "namespaces"("id") ON DELETE CASCADE ON UPDATE CASCADE;
