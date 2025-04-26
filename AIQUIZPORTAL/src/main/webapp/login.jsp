<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // if user already in session, redirect to dashboard
    if (session != null && session.getAttribute("user") != null) {
        response.sendRedirect(request.getContextPath() + "/user/dashboard.jsp");
        return;
    }

    // grab any error message set by LoginServlet
    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>AIQUIZPORTAL • Secure Login</title>
    <style>
        /* Base reset */
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Orbitron','Arial',sans-serif; }
        @import url('https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap');

        body {
            background-color: #0a0a1a;
            color: #00f7ff;
            height:100vh; overflow:hidden;
            display:flex; justify-content:center; align-items:center;
            perspective:1000px;
        }

        /* Starfield background */
        .stars {
            position:fixed; top:0; left:0; width:100%; height:100%; z-index:-2;
            background: radial-gradient(ellipse at bottom,#1B2735 0%,#090A0F 100%);
            overflow:hidden;
        }
        .star {
            position:absolute; background:#fff; border-radius:50%;
            animation:twinkle var(--d) infinite ease-in-out;
        }
        @keyframes twinkle { 0%,100%{opacity:.2} 50%{opacity:1} }

        /* Particle layer */
        .particles { position:fixed; top:0; left:0; width:100%; height:100%; z-index:-1; pointer-events:none; }

        /* Login card */
        .login-container {
            position:relative;
            width:380px;
            padding:40px;
            background:rgba(10,20,40,0.7);
            border-radius:10px;
            box-shadow:0 0 30px rgba(0,247,255,0.3);
            backdrop-filter:blur(10px);
            transform-style:preserve-3d;
            transition:transform .5s ease;
            overflow:hidden;
        }
        /* shine overlay */
        .login-container::before {
            content:'';
            position:absolute; top:-50%; left:-50%;
            width:200%; height:200%;
            background:linear-gradient(to bottom right,transparent,rgba(0,247,255,0.1),transparent);
            transform:rotate(30deg);
            animation:shine 6s infinite linear;
            z-index:-1;
        }
        @keyframes shine { 0%{transform:rotate(30deg) translate(-30%,-30%);} 100%{transform:rotate(30deg) translate(30%,30%);} }

        /* Header */
        .login-header { text-align:center; margin-bottom:30px; }
        .login-header h1 {
            font-size:28px; font-weight:700; letter-spacing:2px;
            background:linear-gradient(90deg,#00f7ff,#0084ff);
            -webkit-background-clip:text; background-clip:text; color:transparent;
            animation:textGlow 2s infinite alternate;
        }
        @keyframes textGlow {
            0%{text-shadow:0 0 5px rgba(0,247,255,.3);}
            100%{text-shadow:0 0 15px rgba(0,247,255,.7),0 0 25px rgba(0,247,255,.4);}
        }
        .login-header p { color:rgba(0,247,255,.7); letter-spacing:1px; font-size:14px; }

        /* Inputs */
        .input-group { position:relative; margin-bottom:25px; }
        .input-group i {
            position:absolute; left:15px; top:50%; transform:translateY(-50%);
            color:rgba(0,247,255,.7); font-size:18px;
            transition:color .3s,text-shadow .3s;
        }
        .input-group input {
            width:100%; padding:15px 20px 15px 45px;
            background:rgba(5,15,30,0.7);
            border:1px solid rgba(0,247,255,.3); border-radius:5px;
            color:#00f7ff; font-size:16px; outline:none;
            transition:border-color .3s,box-shadow .3s;
        }
        .input-group input:focus {
            border-color:#00f7ff; box-shadow:0 0 10px rgba(0,247,255,.5);
        }
        .focus-line {
            position:absolute; bottom:0; left:0; width:0; height:2px;
            background:linear-gradient(90deg,#00f7ff,#0084ff);
            transition:width .3s;
        }
        .input-group input:focus ~ .focus-line { width:100%; }

        /* Remember & forgot */
        .login-options {
            display:flex; justify-content:space-between; align-items:center;
            margin-bottom:25px; font-size:14px;
        }
        .remember-me input { accent-color:#00f7ff; margin-right:8px; }
        .forgot-password a {
            color:rgba(0,247,255,.7); text-decoration:none;
            transition:color .3s,text-shadow .3s;
        }
        .forgot-password a:hover {
            color:#00f7ff; text-shadow:0 0 5px rgba(0,247,255,.5);
        }

        /* Submit */
        .submit-btn {
            width:100%; padding:15px;
            background:linear-gradient(135deg,#00f7ff,#0084ff);
            border:none; border-radius:5px; color:#0a0a1a;
            font-size:16px; font-weight:700; cursor:pointer;
            position:relative; overflow:hidden; transition:all .3s;
        }
        .submit-btn::before {
            content:''; position:absolute; top:0; left:-100%;
            width:100%; height:100%;
            background:linear-gradient(90deg,transparent,rgba(255,255,255,.2),transparent);
            transition:left .5s; z-index:-1;
        }
        .submit-btn:hover::before { left:100%; }
        .submit-btn:hover { box-shadow:0 0 15px rgba(0,247,255,.7); transform:translateY(-2px); }
        .submit-btn:active { transform:translateY(0); }

        /* Signup link */
        .signup-link { text-align:center; margin-top:20px; font-size:14px; }
        .signup-link a {
            color:rgba(0,247,255,.7); text-decoration:none;
            transition:color .3s,text-shadow .3s;
        }
        .signup-link a:hover {
            color:#00f7ff; text-shadow:0 0 5px rgba(0,247,255,.5);
        }

        /* Responsive */
        @media(max-width:480px){
            .login-container { width:90%; padding:30px 20px; }
        }
    </style>
</head>
<body>
    <!-- starfield layer -->
    <div class="stars" id="stars"></div>
    <!-- particle layer -->
    <div class="particles" id="particles"></div>

    <div class="login-container" id="loginContainer">
        <div class="login-header">
            <h1>AIQUIZPORTAL</h1>
            <p>SECURE LOGIN PORTAL</p>
        </div>

        <!-- show error if any -->
        <% if (errorMessage != null) { %>
            <div style="background:#fdecea;color:#b71c1c;padding:10px;border-radius:4px;margin-bottom:20px;text-align:center;">
                <%= errorMessage %>
            </div>
        <% } %>

        <form action="<%=request.getContextPath()%>/LoginServlet" method="post" id="loginForm">
            <div class="input-group">
                <i class="fas fa-user-astronaut"></i>
                <input type="text" name="email" placeholder="EMAIL" required>
                <div class="focus-line"></div>
            </div>

            <div class="input-group">
                <i class="fas fa-lock"></i>
                <input id="password" type="password" name="password" placeholder="PASSWORD" required>
                <div class="focus-line"></div>
            </div>

            <div class="login-options">
                <label class="remember-me">
                    <input type="checkbox" name="rememberMe" id="remember"> Remember me
                </label>
                <div class="forgot-password">
                    <a href="forgotPassword.jsp">Forgot password?</a>
                </div>
            </div>

            <button type="submit" class="submit-btn" id="submitBtn">
                <i class="fas fa-sign-in-alt"></i> LOGIN
            </button>

            <div class="signup-link">
                New here? <a href="register.jsp">Create account</a>
            </div>
        </form>
    </div>

    <!-- Font Awesome & scripts -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
    <script>
        // generate stars
        const stars = document.getElementById('stars');
        for(let i=0;i<150;i++){
            const s=document.createElement('div');
            s.className='star';
            const size=Math.random()*2+1;
            s.style.setProperty('--d', (Math.random()*5+3)+'s');
            s.style.width=size+'px'; s.style.height=size+'px';
            s.style.left=Math.random()*100+'%';
            s.style.top=Math.random()*100+'%';
            stars.append(s);
        }

        // generate particles
        const parts = document.getElementById('particles');
        for(let i=0;i<30;i++){
            const p=document.createElement('div');
            p.className='particle';
            const sz=Math.random()*4+1;
            p.style.width=sz+'px'; p.style.height=sz+'px';
            p.style.left=Math.random()*100+'%'; p.style.top=Math.random()*100+'%';
            p.style.opacity=Math.random()*0.5+0.1;
            p.style.background='rgba(0,247,255,0.5)';
            p.style.animation=`float ${Math.random()*10+5}s infinite ease-in-out ${Math.random()*5}s`;
            parts.append(p);
        }
        // float keyframes
        const style=document.createElement('style');
        style.innerHTML=`@keyframes float {
            0%,100%{transform:translate(0,0)}
            25%{transform:translate(${Math.random()*100-50}px,${Math.random()*100-50}px)}
            50%{transform:translate(${Math.random()*100-50}px,${Math.random()*100-50}px)}
            75%{transform:translate(${Math.random()*100-50}px,${Math.random()*100-50}px)}
        }`;
        document.head.append(style);

        // 3D tilt
        const lc=document.getElementById('loginContainer');
        lc.addEventListener('mousemove',e=>{
            const x=(window.innerWidth/2-e.pageX)/25;
            const y=(window.innerHeight/2-e.pageY)/25;
            lc.style.transform=`rotateY(${x}deg) rotateX(${y}deg)`;
        });
        lc.addEventListener('mouseleave',()=>lc.style.transform='rotateY(0) rotateX(0)');

        // Show/hide password
        const pwdField = document.getElementById('password');
        pwdField.insertAdjacentHTML('afterend','<i class="fas fa-eye" id="togglePwd" style="position:absolute; right:15px; top:calc(50% - 9px); color:rgba(0,247,255,.7);cursor:pointer;"></i>');
        document.getElementById('togglePwd').addEventListener('click',function(){
            const t = pwdField.getAttribute('type')==='password'?'text':'password';
            pwdField.setAttribute('type',t);
            this.classList.toggle('fa-eye-slash');
        });

        // form submit loading indicator
        document.getElementById('loginForm').addEventListener('submit',e=>{
            const btn=document.getElementById('submitBtn');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> AUTHENTICATING';
            btn.disabled = true;
        });
    </script>
</body>
</html>
