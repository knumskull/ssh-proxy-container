FROM registry.redhat.io/ubi9/ubi-init
RUN dnf install openssh-server -y ; \
    systemctl enable sshd
# Create the SSH user
RUN useradd -m -s /bin/bash ssh-user

# Set up SSH keys for the user
RUN mkdir -p /home/ssh-user/.ssh && \
    chmod 700 /home/ssh-user/.ssh

# Copy the public key into the authorized_keys file
COPY authorized_keys /home/ssh-user/.ssh/authorized_keys
RUN chmod 600 /home/ssh-user/.ssh/authorized_keys && \
    chown -R ssh-user:ssh-user /home/ssh-user/.ssh

# Expose the SSH port
EXPOSE 2222
