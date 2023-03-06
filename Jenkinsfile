pipeline {
    agent any

    stages {
        stage('git clone') {
            steps {
                sh 'git clone git@github.com:khyathieswar7/CICD-flow-static.git'
            }
        }
         stage('ci') {
            steps {
                sh '''zip -r ./index.html apache.zip
                aws s3 cp apache s3://cicd-khyathi-static/'''
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