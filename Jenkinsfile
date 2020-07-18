pipeline {
    agent { label 'ruby' }

    options {
        skipStagesAfterUnstable()
    }

    stages {
        stage('Setup') {
            steps {
                sh 'bundle install'
            }
        }
        stage('Run tests and generate docs') {
            steps {
                sh 'bundle exec rake spec'
                sh 'bundle exec rake yard'
            }
        }

        stage('Build') {
            steps {
                sh 'bundle exec rake build'
            }
        }
    }

    post {
        always {
            junit 'test-reports/**/*.xml'
        }
    }
}
