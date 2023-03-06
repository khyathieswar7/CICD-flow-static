pipeline {
    agent any

    stages {
        stage('ci') {
            steps {
                sh ''' zip -r khyathi.zip ./index.html
                aws s3 cp khyathi.zip s3://cicd-khyathi-static1/'''
            }
        }
       stage('cd') {
            steps {
                sh ''' rm -fr index.html
                aws s3 cp s3://cicd-khyathi-static1/khyathi.zip .
                unzip khyathi.zip
                scp -r index.html root@172.31.57.16:/var/www/html/'''
            }
        } 
    }
}