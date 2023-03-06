pipeline {
    agent any

    stages {
         stage('ci') {
            steps {
                sh '''zip -r apache.zip ./index.html
                aws s3 cp apache.zip s3://cicd-khyathi-static/'''
            }
        }
        stage('cd') {
            steps {
                sh '''aws s3 cp apache.zip s3://cicd-khyathi-static/apache.zip .
                unzip apache.zip
                scp -r index.html root@172.31.51.85:/var/www/html/'''
            }
        }
    }
}