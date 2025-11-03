# backet.tf
resource "yandex_iam_service_account" "sa" {
  name        = "sa-for-bucket"
  description = "Service account for bucket management"
}

# Даем сервисному аккаунту роль администратора хранилища
resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Создаем статический ключ
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

# Создаем бакет
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "bucket-olya2025"
}

# Добавляем случайный суффикс чтобы имя бакета было уникальным
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# Если нужен публичный доступ, используем policy
resource "yandex_storage_bucket_policy" "public_read" {
  bucket     = yandex_storage_bucket.test.bucket
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::${yandex_storage_bucket.test.bucket}/*"
      },
    ]
  })
}