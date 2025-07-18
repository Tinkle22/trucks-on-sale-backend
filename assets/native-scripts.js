// Native Web Interface JavaScript

// Change main image in gallery
function changeMainImage(imageSrc) {
    const mainImage = document.getElementById('mainImage');
    if (mainImage) {
        mainImage.src = imageSrc;
        
        // Update active thumbnail
        const thumbnails = document.querySelectorAll('.thumbnail');
        thumbnails.forEach(thumb => {
            thumb.classList.remove('active');
            if (thumb.src === imageSrc) {
                thumb.classList.add('active');
            }
        });
    }
}

// View vehicle details
function viewVehicle(vehicleId) {
    const currentUrl = new URL(window.location);
    currentUrl.searchParams.set('vehicle', vehicleId);
    
    // Remove search parameters when viewing a specific vehicle
    const searchParams = ['category', 'condition', 'price', 'minYear', 'maxYear', 'region', 'make', 'model', 'mileage', 'transmission', 'fuelType'];
    searchParams.forEach(param => {
        currentUrl.searchParams.delete(param);
    });
    
    window.location.href = currentUrl.toString();
}

// Contact dealer
function contactDealer() {
    // Try to get dealer phone from the page
    const dealerPhone = document.querySelector('.dealer-details p:has(i.fa-phone)')?.textContent?.trim();
    
    if (dealerPhone) {
        // Extract phone number
        const phoneNumber = dealerPhone.replace(/[^\d+]/g, '');
        if (phoneNumber) {
            window.location.href = `tel:${phoneNumber}`;
            return;
        }
    }
    
    // Fallback to general contact
    showContactModal();
}

// Show contact modal
function showContactModal() {
    const modal = document.createElement('div');
    modal.className = 'contact-modal';
    modal.innerHTML = `
        <div class="modal-overlay" onclick="closeContactModal()">
            <div class="modal-content" onclick="event.stopPropagation()">
                <div class="modal-header">
                    <h3>Contact Us</h3>
                    <button onclick="closeContactModal()" class="close-btn">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Get in touch with us for more information about this vehicle:</p>
                    <div class="contact-options">
                        <a href="tel:+27123456789" class="contact-option">
                            <i class="fas fa-phone"></i>
                            <span>Call Us: +27 12 345 6789</span>
                        </a>
                        <a href="mailto:info@trucksonsale.co.za" class="contact-option">
                            <i class="fas fa-envelope"></i>
                            <span>Email: info@trucksonsale.co.za</span>
                        </a>
                        <a href="https://wa.me/27123456789" target="_blank" class="contact-option">
                            <i class="fab fa-whatsapp"></i>
                            <span>WhatsApp: +27 12 345 6789</span>
                        </a>
                    </div>
                    <div class="app-download">
                        <p>For the best experience, download our mobile app:</p>
                        <button onclick="downloadApp()" class="btn btn-primary">
                            <i class="fas fa-mobile-alt"></i> Download App
                        </button>
                    </div>
                </div>
            </div>
        </div>
    `;
    
    document.body.appendChild(modal);
    
    // Add modal styles if not already present
    if (!document.getElementById('modal-styles')) {
        const styles = document.createElement('style');
        styles.id = 'modal-styles';
        styles.textContent = `
            .contact-modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: 1000;
            }
            
            .modal-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }
            
            .modal-content {
                background: white;
                border-radius: 12px;
                max-width: 500px;
                width: 100%;
                max-height: 90vh;
                overflow-y: auto;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }
            
            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1.5rem;
                border-bottom: 1px solid #eee;
            }
            
            .modal-header h3 {
                margin: 0;
                color: #333;
            }
            
            .close-btn {
                background: none;
                border: none;
                font-size: 1.5rem;
                cursor: pointer;
                color: #666;
                padding: 0;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .close-btn:hover {
                color: #FF0000;
            }
            
            .modal-body {
                padding: 1.5rem;
            }
            
            .contact-options {
                margin: 1.5rem 0;
            }
            
            .contact-option {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem;
                margin-bottom: 0.5rem;
                background: #f8f9fa;
                border-radius: 8px;
                text-decoration: none;
                color: #333;
                transition: all 0.3s ease;
            }
            
            .contact-option:hover {
                background: #e9ecef;
                transform: translateX(5px);
            }
            
            .contact-option i {
                font-size: 1.2rem;
                color: #FF0000;
                width: 20px;
            }
            
            .app-download {
                text-align: center;
                padding-top: 1.5rem;
                border-top: 1px solid #eee;
            }
            
            .app-download p {
                margin-bottom: 1rem;
                color: #666;
            }
        `;
        document.head.appendChild(styles);
    }
}

// Close contact modal
function closeContactModal() {
    const modal = document.querySelector('.contact-modal');
    if (modal) {
        modal.remove();
    }
}

// Share vehicle
function shareVehicle() {
    const url = window.location.href;
    const title = document.title;
    
    if (navigator.share) {
        navigator.share({
            title: title,
            url: url
        }).catch(console.error);
    } else {
        // Fallback to copying URL
        copyToClipboard(url);
        showNotification('Link copied to clipboard!');
    }
}

// Copy to clipboard
function copyToClipboard(text) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text);
    } else {
        // Fallback for older browsers
        const textArea = document.createElement('textarea');
        textArea.value = text;
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
    }
}

// Show notification
function showNotification(message) {
    const notification = document.createElement('div');
    notification.className = 'notification';
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        background: #4CAF50;
        color: white;
        padding: 1rem 1.5rem;
        border-radius: 8px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        z-index: 1001;
        animation: slideIn 0.3s ease;
    `;
    
    // Add animation keyframes if not already present
    if (!document.getElementById('notification-styles')) {
        const styles = document.createElement('style');
        styles.id = 'notification-styles';
        styles.textContent = `
            @keyframes slideIn {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            
            @keyframes slideOut {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(100%);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(styles);
    }
    
    document.body.appendChild(notification);
    
    // Remove notification after 3 seconds
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.parentNode.removeChild(notification);
            }
        }, 300);
    }, 3000);
}

// Download app
function downloadApp() {
    const userAgent = navigator.userAgent || navigator.vendor || window.opera;
    
    // Check if it's iOS
    if (/iPad|iPhone|iPod/.test(userAgent) && !window.MSStream) {
        // Redirect to App Store (replace with actual App Store URL)
        window.open('https://apps.apple.com/app/trucks-on-sale', '_blank');
    }
    // Check if it's Android
    else if (/android/i.test(userAgent)) {
        // Redirect to Google Play Store (replace with actual Play Store URL)
        window.open('https://play.google.com/store/apps/details?id=com.trucksonsale', '_blank');
    }
    // Desktop or other devices
    else {
        showNotification('Visit our website on your mobile device to download the app!');
    }
}

// Initialize page
document.addEventListener('DOMContentLoaded', function() {
    // Add smooth scrolling
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Add loading animation to images
    const images = document.querySelectorAll('img');
    images.forEach(img => {
        img.addEventListener('load', function() {
            this.style.opacity = '1';
        });
        
        img.addEventListener('error', function() {
            this.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZGRkIi8+PHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCwgc2Fucy1zZXJpZiIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5OSIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPk5vIEltYWdlPC90ZXh0Pjwvc3ZnPg==';
            this.alt = 'No Image Available';
        });
    });
    
    // Add intersection observer for animations
    if ('IntersectionObserver' in window) {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        });
        
        // Observe elements for animation
        document.querySelectorAll('.vehicle-card, .info-item').forEach(el => {
            el.style.opacity = '0';
            el.style.transform = 'translateY(20px)';
            el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            observer.observe(el);
        });
    }
    
    // Handle back button for mobile
    if (window.history && window.history.pushState) {
        window.addEventListener('popstate', function(e) {
            // Handle browser back button
            if (e.state && e.state.page) {
                // Custom handling if needed
            }
        });
    }
});

// Handle keyboard navigation
document.addEventListener('keydown', function(e) {
    // Close modal on Escape key
    if (e.key === 'Escape') {
        closeContactModal();
    }
    
    // Navigate images with arrow keys
    if (e.key === 'ArrowLeft' || e.key === 'ArrowRight') {
        const thumbnails = document.querySelectorAll('.thumbnail');
        const activeThumbnail = document.querySelector('.thumbnail.active');
        
        if (thumbnails.length > 1 && activeThumbnail) {
            const currentIndex = Array.from(thumbnails).indexOf(activeThumbnail);
            let newIndex;
            
            if (e.key === 'ArrowLeft') {
                newIndex = currentIndex > 0 ? currentIndex - 1 : thumbnails.length - 1;
            } else {
                newIndex = currentIndex < thumbnails.length - 1 ? currentIndex + 1 : 0;
            }
            
            thumbnails[newIndex].click();
        }
    }
});

// Add touch gestures for mobile
let touchStartX = 0;
let touchEndX = 0;

document.addEventListener('touchstart', function(e) {
    touchStartX = e.changedTouches[0].screenX;
});

document.addEventListener('touchend', function(e) {
    touchEndX = e.changedTouches[0].screenX;
    handleSwipe();
});

function handleSwipe() {
    const swipeThreshold = 50;
    const diff = touchStartX - touchEndX;
    
    if (Math.abs(diff) > swipeThreshold) {
        const thumbnails = document.querySelectorAll('.thumbnail');
        const activeThumbnail = document.querySelector('.thumbnail.active');
        
        if (thumbnails.length > 1 && activeThumbnail) {
            const currentIndex = Array.from(thumbnails).indexOf(activeThumbnail);
            let newIndex;
            
            if (diff > 0) { // Swipe left
                newIndex = currentIndex < thumbnails.length - 1 ? currentIndex + 1 : 0;
            } else { // Swipe right
                newIndex = currentIndex > 0 ? currentIndex - 1 : thumbnails.length - 1;
            }
            
            thumbnails[newIndex].click();
        }
    }
}
